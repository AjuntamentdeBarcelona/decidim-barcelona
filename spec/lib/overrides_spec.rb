# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/application_controller.rb" => "3fa179cac8605b5bf472ea276d3f788a", # ephemeral participation overrides
      "/app/helpers/decidim/decidim_form_helper.rb" => "c534a1faa8da83aab5b2190f9d7534c3", # ephemeral participation overrides
      "/app/models/decidim/component.rb" => "7fdd302396760cdccd5fab8adc6a0976", # ephemeral participation overrides
      "/app/models/decidim/organization.rb" => "04eaf4467a1e0d891251c5cedf71f5e4", # ephemeral participation overrides
      "/app/models/decidim/permission_action.rb" => "3ad166f375e32d3cbb19fd6ca97fa659", # ephemeral participation overrides
      "/app/models/decidim/user.rb" => "81da9f2f82f6336a92b948d827bd0fb3", # ephemeral participation overrides
      "/app/packs/stylesheets/decidim/email.scss" => "7e6a7b5d0327696b8a9d481fdb8d8d70",
      "/app/permissions/decidim/permissions.rb" => "36a9c31bbf17685e80acff49f6e9b0ca", # ephemeral participation overrides
      "/app/views/decidim/shared/_login_modal.html.erb" => "a29d4fcebe8c689044e3c15f6144f3d1", # ephemeral participation overrides
      "/app/views/layouts/decidim/mailer.html.erb" => "0c7804de08649c8d3c55c117005e51c9",
      "/app/views/layouts/decidim/footer/_main_links.html.erb" => "60a25ee1b5c6c3702a3d158ac9e23013", # ephemeral participation overrides
      "/app/views/layouts/decidim/header/_main_links_dropdown.html.erb" => "a369664c2bb36cbd2b10d90d9a7469cf", # ephemeral participation overrides
      "/app/views/layouts/decidim/widget.html.erb" => "b9fb503118ee33d298cbc585995e216c",
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "2ddcb8ba5070f7cdb231283185f2c213",
      "/app/cells/decidim/activities_cell.rb" => "af9e9e2b6e4134fa90b6699bbf7da428",
      "/app/cells/decidim/user_profile_cell.rb" => "30627556740555814f5cf279491aee94",
      "/lib/decidim/search_resource_fields_mapper.rb" => "ff2cc476eb72c2942cf2e69ae21b84fa"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/publish_component.rb" => "48b73691b2aea10191ed427702a74359", # revert https://github.com/decidim/decidim/pull/10690
      "/app/commands/decidim/admin/transfer_user.rb" => "7cf11abc98c3a0c4a656ab96c220dd6a", # ephemeral participation overrides
      "/app/controllers/decidim/admin/conflicts_controller.rb" => "302e429f37690acac4499e7f9fb2ea18", # ephemeral participation overrides
      "/app/forms/decidim/admin/component_form.rb" => "0455dd26580817470fd7096ef6b08315", # ephemeral participation overrides
      "/app/forms/decidim/admin/permissions_form.rb" => "f68d00a490e84524ce3aebe6f71d829a" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/project_vote_button_cell.rb" => "449d31680f5f9044dc1ed7adcd915874", # ephemeral participation overrides
      "/app/views/decidim/budgets/projects/_project_budget_button.html.erb" => "c81c840fd8487e48ce9f7a985cb88604" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-verifications",
    files: {
      "/app/commands/decidim/verifications/perform_authorization_step.rb" => "aaa4529daa08669a5039b786b97d7d47", # ephemeral participation overrides
      "/app/services/decidim/authorization_handler.rb" => "2a905e81dfc8586abe9eddba36653b35", # ephemeral participation overrides
      "/lib/decidim/verifications/workflow_manifest.rb" => "fa679770a0df3381298e4bc19f6d4e89" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/forms/decidim/system/update_organization_form.rb" => "a1059e5a8745a2637703b6805deda53c", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/edit.html.erb" => "b3ca773290213f267c5d6f0083aca539", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/new.html.erb" => "4916cdb428d89de5afe60e279d64112f" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-accountability",
    files: {
      "/app/views/decidim/accountability/results/home.html.erb" => "79a3df85ac336eb449fbf4d545c5ee03",
      "/app/models/decidim/accountability/result.rb" => "aa9e2c5394152e22ad5d0c3547637230",
      "/app/services/decidim/accountability/results_calculator.rb" => "59df612241e5ed2b33ee2ab32af87621",
      "/app/views/decidim/accountability/results/_results_leaf.html.erb" => "4c9493268b778c6c2c356616d7a8886a",
      "/app/views/decidim/accountability/results/_show_leaf.html.erb" => "7c99f542c9cb2ef72dbe2f86e285bd26"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_m_cell.rb" => "a20b707d0533dd8883b0bdbf8bc0b2c0",
      "/app/cells/decidim/initiatives/initiative_m/footer.erb" => "3f4017aa1dd1cb30b26843ab92b32031",
      "/app/models/decidim/initiative.rb" => "7d88ac2fb9827c2c6cdbe39c2f1df908",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "805ba1e544cc3883baec90a357596320",
      "/app/views/layouts/decidim/_initiative_header_steps.html.erb" => "b82f930fafd65df4170f8a6ffc7595bd",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "ecb8b4c7e417c3dc979e7f64c19f96a5",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "2c3068724ed2986f62bd13994960f39e"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "66ee99695217f75939deed77f6f88159",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "9557df6e46040a6395c71c75cd84792c",
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "20564c5da2200ed0c9fe42c457af26cb",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "678306ecfe31b67a1d4f13a10d189c74",
      "/app/models/decidim/meetings/meeting.rb" => "21a6908ff3e9d080fbf0235ba924fc97",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "c4b88c68ea8b5653c6f1e35cd2646011",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "38ce368638f4ac344faea5f0307f09de",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "2c5628f8d02af54ad857508e33e212a3"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/presenters/decidim/proposals/proposal_presenter.rb" => "105b7266bcdd8b947ababbb7ebb78789"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/views/decidim/forms/admin/questionnaires/answers/show.html.erb" => "49e39b6688f3109b87ec74890bc566fb"
    }
  },
  {
    # Fix origami date compatibility with Ruby 3.0 monkey-patching it on origami_date.rb
    package: "origami",
    files: {
      "/lib/origami/string.rb" => "1a8d718ef6a044183298eb92b650be75"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])

    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
