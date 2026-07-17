# frozen_string_literal: true

require "rails_helper"

describe "In-person attendees count stat" do
  subject { stats.resolve(:in_person_attendees_count, components) }

  let(:stats) { Decidim.find_component_manifest(:meetings).stats }
  let(:component) { create(:meeting_component, :published) }
  let(:components) { Decidim::Component.where(id: component.id) }

  it "is registered with medium priority and visible to non-admins" do
    stat = stats.stats.find { |definition| definition[:name] == :in_person_attendees_count }

    expect(stat[:priority]).to eq(Decidim::StatsRegistry::MEDIUM_PRIORITY)
    expect(stat[:admin]).to be(false)
  end

  it "sums the attendees of closed, published, in-person meetings" do
    create(:meeting, :published, :closed, :in_person, component:, attendees_count: 10)
    create(:meeting, :published, :closed, :in_person, component:, attendees_count: 5)

    expect(subject).to eq(15)
  end

  it "ignores online and hybrid meetings" do
    create(:meeting, :published, :closed, :online, component:, attendees_count: 10)
    create(:meeting, :published, :closed, :hybrid, component:, attendees_count: 20)
    create(:meeting, :published, :closed, :in_person, component:, attendees_count: 3)

    expect(subject).to eq(3)
  end

  it "ignores meetings that are not closed" do
    create(:meeting, :published, :in_person, component:)
    create(:meeting, :published, :closed, :in_person, component:, attendees_count: 7)

    expect(subject).to eq(7)
  end

  it "ignores meetings whose closing report is not visible" do
    create(:meeting, :published, :closed, :in_person, component:, attendees_count: 10, closing_visible: false)

    expect(subject).to eq(0)
  end

  it "ignores unpublished and hidden meetings" do
    create(:meeting, :closed, :in_person, component:, attendees_count: 10)
    create(:meeting, :published, :closed, :in_person, :hidden, component:, attendees_count: 20)

    expect(subject).to eq(0)
  end

  it "ignores meetings from other components" do
    other_component = create(:meeting_component, :published)
    create(:meeting, :published, :closed, :in_person, component: other_component, attendees_count: 10)

    expect(subject).to eq(0)
  end
end
