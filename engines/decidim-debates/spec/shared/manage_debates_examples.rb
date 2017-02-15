# -*- coding: utf-8 -*-
# frozen_string_literal: true
RSpec.shared_examples "manage debates" do
  it "updates a debate" do
    within find("tr", text: translated(debate.title)) do
      click_link "Editar"
    end

    within ".edit_debate" do
      fill_in_i18n(
        :debate_title,
        "#title-tabs",
        es: "Mi nuevo título",
        ca: "El meu nou títol"
      )

      find("*[type=submit]").click
    end

    within ".flash" do
      expect(page).to have_content("correctament")
    end

    within "table" do
      expect(page).to have_content("El meu nou títol")
    end
  end

  context "previewing debates" do
    it "allows the user to preview the debate" do
      new_window = window_opened_by { click_link translated(debate.title) }

      within_window new_window do
        expect(current_path).to eq decidim_debates.debate_path(id: debate.id, participatory_process_id: participatory_process.id, feature_id: current_feature.id)
        expect(page).to have_content(translated(debate.title))
      end
    end
  end

  it "creates a new debate" do
    find(".actions .new").click

    within ".new_debate" do
      fill_in_i18n(
        :debate_title,
        "#title-tabs",
        es: "Mi debate",
        ca: "El meu debat"
      )
      fill_in_i18n_editor(
        :debate_description,
        "#description-tabs",
        es: "Descripción más larga",
        ca: "Descripció més llarga"
      )
      fill_in_i18n_editor(
        :debate_instructions,
        "#instructions-tabs",
        es: "Instrucciones más largas",
        ca: "Instruccions més llargues"
      )

      fill_in :debate_start_time, with: 1.day.from_now
      fill_in :debate_end_time, with: 1.day.from_now + 2.hours

      select translated(category.name), from: :debate_decidim_category_id

      find("*[type=submit]").click
    end

    within ".flash" do
      expect(page).to have_content("correctament")
    end

    within "table" do
      expect(page).to have_content("El meu debat")
    end
  end

  context "deleting a debate" do
    let!(:debate2) { create(:debate, feature: current_feature) }

    before do
      visit current_path
    end

    it "deletes a debate" do
      within find("tr", text: translated(debate2.title)) do
        click_link "Esborrar"
      end

      within ".flash" do
        expect(page).to have_content("correctament")
      end

      within "table" do
        expect(page).to_not have_content(translated(debate2.title))
      end
    end
  end
end
