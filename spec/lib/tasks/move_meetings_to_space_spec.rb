# frozen_string_literal: true

require "rails_helper"
require "decidim/comments/test/factories"

describe "rake meetings:move_to_space" do
  let(:organization) { create(:organization) }
  let(:source_assembly) { create(:assembly, :published, organization:) }
  let(:target_assembly) { create(:assembly, :published, organization:) }
  let(:source_component) { create(:meeting_component, :published, participatory_space: source_assembly) }
  let!(:target_component) { create(:meeting_component, :published, participatory_space: target_assembly) }

  let!(:meeting) { create(:meeting, :published, component: source_component) }
  let!(:other_meeting) { create(:meeting, :published, component: source_component) }
  let!(:comment) { create(:comment, commentable: meeting) }
  let!(:reply) { create(:comment, commentable: comment, root_commentable: meeting) }
  let!(:meeting_moderation) { create(:moderation, reportable: meeting) }
  let!(:comment_moderation) { create(:moderation, reportable: comment) }

  let(:env) { { "MEETING_IDS" => meeting.id.to_s, "TARGET_COMPONENT" => target_component.id.to_s } }

  before do
    Rails.application.load_tasks unless Rake::Task.task_defined?("meetings:move_to_space")
    Rake::Task["meetings:move_to_space"].reenable
  end

  def run_task(env)
    keys = %w(MEETING_IDS TARGET_COMPONENT TARGET_ASSEMBLY APPLY)
    previous = ENV.to_h.slice(*keys)
    keys.each { |key| ENV.delete(key) }
    ENV.update(env)
    Rake::Task["meetings:move_to_space"].invoke
  ensure
    keys.each { |key| ENV.delete(key) }
    ENV.update(previous)
  end

  def space_of(record)
    record.reload.slice(:decidim_participatory_space_type, :decidim_participatory_space_id).values
  end

  context "without APPLY" do
    it "reports and writes nothing" do
      expect { run_task(env) }.to output(/Dry run\. Nothing was written/).to_stdout

      expect(meeting.reload.component).to eq(source_component)
      expect(space_of(comment)).to eq(["Decidim::Assembly", source_assembly.id])
      expect(space_of(meeting_moderation)).to eq(["Decidim::Assembly", source_assembly.id])
    end
  end

  context "with APPLY=1" do
    before { expect { run_task(env.merge("APPLY" => "1")) }.to output(/Moved 1 meetings, 2 comments and 2 moderations/).to_stdout }

    it "moves the meeting to the target component" do
      expect(meeting.reload.component).to eq(target_component)
      expect(other_meeting.reload.component).to eq(source_component)
    end

    it "moves the comments and replies to the target space" do
      expect(space_of(comment)).to eq(["Decidim::Assembly", target_assembly.id])
      expect(space_of(reply)).to eq(["Decidim::Assembly", target_assembly.id])
    end

    it "moves the moderations of the meeting and of its comments to the target space" do
      expect(space_of(meeting_moderation)).to eq(["Decidim::Assembly", target_assembly.id])
      expect(space_of(comment_moderation)).to eq(["Decidim::Assembly", target_assembly.id])
    end

    it "reindexes the meeting under the target space" do
      spaces = Decidim::SearchableResource.where(resource: meeting).pluck(:decidim_participatory_space_id).uniq

      expect(spaces).to eq([target_assembly.id])
    end
  end

  context "with TARGET_ASSEMBLY" do
    let(:env) { { "MEETING_IDS" => meeting.id.to_s, "TARGET_ASSEMBLY" => target_assembly.slug, "APPLY" => "1" } }

    it "uses the only meetings component of the assembly" do
      expect { run_task(env) }.to output(/Moved 1 meetings/).to_stdout

      expect(meeting.reload.component).to eq(target_component)
    end

    it "stops when the assembly has no meetings component" do
      target_component.destroy!

      expect { run_task(env) }.to raise_error(SystemExit).and output(/has no meetings component/).to_stderr
      expect(meeting.reload.component).to eq(source_component)
    end

    it "stops when the assembly has several meetings components" do
      create(:meeting_component, participatory_space: target_assembly)

      expect { run_task(env) }.to raise_error(SystemExit).and output(/Choose one with TARGET_COMPONENT/).to_stderr
      expect(meeting.reload.component).to eq(source_component)
    end
  end

  it "stops when a meeting does not exist" do
    ids = "#{meeting.id},#{other_meeting.id + 1000}"

    expect { run_task(env.merge("MEETING_IDS" => ids, "APPLY" => "1")) }
      .to raise_error(SystemExit)
      .and output(/Meetings not found: #{other_meeting.id + 1000}/).to_stderr
      .and output.to_stdout
    expect(meeting.reload.component).to eq(source_component)
  end

  it "stops when the target component is not a meetings component" do
    pages = create(:component, manifest_name: "pages", participatory_space: target_assembly)

    expect { run_task(env.merge("TARGET_COMPONENT" => pages.id.to_s, "APPLY" => "1")) }
      .to raise_error(SystemExit).and output(/not a meetings one/).to_stderr
    expect(meeting.reload.component).to eq(source_component)
  end

  it "flags links to resources of other spaces" do
    proposal = create(:proposal, component: create(:proposal_component, participatory_space: source_assembly))
    meeting.link_resources([proposal], "proposals_from_meeting")

    expect { run_task(env) }.to output(/Decidim::Proposals::Proposal #{proposal.id}: WILL STOP SHOWING/).to_stdout
  end
end
