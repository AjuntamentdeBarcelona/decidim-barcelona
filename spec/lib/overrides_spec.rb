# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/helpers/decidim/paginate_helper.rb" => "6cd2b5699bce845d76e9e76f239783cc",
      "/app/controllers/decidim/application_controller.rb" => "3fa179cac8605b5bf472ea276d3f788a", # ephemeral participation overrides
      "/app/helpers/decidim/decidim_form_helper.rb" => "c534a1faa8da83aab5b2190f9d7534c3", # ephemeral participation overrides
      "/app/models/decidim/component.rb" => "7fdd302396760cdccd5fab8adc6a0976", # ephemeral participation overrides
      "/app/models/decidim/organization.rb" => "04eaf4467a1e0d891251c5cedf71f5e4", # ephemeral participation overrides
      "/app/models/decidim/permission_action.rb" => "3ad166f375e32d3cbb19fd6ca97fa659", # ephemeral participation overrides
      "/app/models/decidim/user.rb" => "81da9f2f82f6336a92b948d827bd0fb3", # ephemeral participation overrides
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "be1d2c978a80cca492954666677cd4bd",
      "/app/permissions/decidim/permissions.rb" => "36a9c31bbf17685e80acff49f6e9b0ca", # ephemeral participation overrides
      "/app/views/decidim/shared/_login_modal.html.erb" => "a29d4fcebe8c689044e3c15f6144f3d1", # ephemeral participation overrides
      "/app/views/layouts/decidim/mailer.html.erb" => "4e308c82acd8b1dac405ff71963d8743",
      "/app/views/layouts/decidim/footer/_main_links.html.erb" => "60a25ee1b5c6c3702a3d158ac9e23013", # ephemeral participation overrides
      "/app/views/layouts/decidim/header/_main_links_dropdown.html.erb" => "a369664c2bb36cbd2b10d90d9a7469cf", # ephemeral participation overrides
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "22355fa93da7c8776e7e7f56a5b207f7",
      "/app/cells/decidim/activities_cell.rb" => "dd17416a8d1efe7f26b1e759613e4db4",
      "/app/cells/decidim/user_profile_cell.rb" => "71216a17c7eea8dd8ebc1ea3907efaef",
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
      "/app/views/decidim/participatory_spaces/_result.html.erb" => "36add6a46776f600922fa04099a20909",
      "/app/cells/decidim/accountability/result_l/extra_data.erb" => "58368fec1e36bff35cc3ea24c2109076",
      "/app/cells/decidim/accountability/status/status.erb" => "d6e3d97dcc7cf8613047a6d2549e0e27",
      "/app/views/decidim/accountability/results/home.html.erb" => "eefb76bf9388e4cea81b56ccd5d161a9",
      "/app/views/decidim/accountability/results/index.html.erb" => "e85be11b2d5dad3e6ed97b6f719287d4",
      "/app/views/decidim/accountability/results/_home_categories.html.erb" => "00721e6e14f5ad718a3d80ecd905999e",
      "/app/views/decidim/accountability/results/_scope_filters.html.erb" => "02f6546d773cab4a8c006ffaf86e625e",
      "/app/views/decidim/accountability/results/_stats_box.html.erb" => "2ce34e1ee1a824dc4fbe36940c97f3e8",
      "/app/models/decidim/accountability/result.rb" => "e1c063ba7c39ca8996daa740c7ff6bc6",
      "/app/services/decidim/accountability/results_calculator.rb" => "4cc5ed480220f0bfe7561ad887e59576"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_metadata_g_cell.rb" => "e41380534ae3c4c441530a6739e3746a",
      "/app/models/decidim/initiative.rb" => "77c9775fcff404b16e5a382915116fe1",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "805ba1e544cc3883baec90a357596320",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "40c663fcb732743399b4fe79605e7823"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "f885f36957b27f20535c8d5b985ecee5",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "ea7e1dab09b0c39b670dbfd05046572b",
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "726b1c957fdadd355171364b3327564a",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "b7bba47ba0a6466a14dbd3798c2e620b",
      "/app/models/decidim/meetings/meeting.rb" => "2998095d4eb8fcacd83700098de6c285",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "b5cb5d2f044b30d348f891f56f851a02",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "8be62c6b0cc2f13d4be68eb5e06217de",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "7e24a3e70c213dcbc046275cb438744d"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/presenters/decidim/proposals/proposal_presenter.rb" => "72910541010305f25baf297f4a58497b"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/views/decidim/forms/admin/questionnaires/answers/show.html.erb" => "ab1f126851dddc3b70c970c5825ca1fa"
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
