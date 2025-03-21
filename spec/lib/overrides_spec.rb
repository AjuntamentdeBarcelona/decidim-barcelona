# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overridden is the same
# as the expected. If this test fails, it means that the overridden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/helpers/decidim/paginate_helper.rb" => "6fd69359386319d678c7a17cf64de4d9",
      "/app/controllers/decidim/application_controller.rb" => "cb88710d9d065501b19d95864760fa3f", # ephemeral participation overrides
      "/app/controllers/concerns/decidim/paginable.rb" => "a42381a0883c92df189ac61cebea3047", # update per_page method in assemblies_controller_override.rb
      "/app/helpers/decidim/decidim_form_helper.rb" => "383f4d57504a30a17e802ac29f9a047c", # ephemeral participation overrides
      "/app/models/decidim/component.rb" => "104dcccde6393f5fa92509b1d2c38d05", # ephemeral participation overrides
      "/app/models/decidim/organization.rb" => "a72b9d9ef10aa06dbe5aef27c68d5c7a", # ephemeral participation overrides
      "/app/models/decidim/permission_action.rb" => "3ad166f375e32d3cbb19fd6ca97fa659", # ephemeral participation overrides
      "/app/models/decidim/user.rb" => "15925bc5ad7efb7508c48f4e10fced48", # ephemeral participation overrides
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "be1d2c978a80cca492954666677cd4bd",
      "/app/permissions/decidim/permissions.rb" => "36a9c31bbf17685e80acff49f6e9b0ca", # ephemeral participation overrides
      "/app/views/decidim/shared/_login_modal.html.erb" => "0d615603bb45f7b209032578dda9fc72", # ephemeral participation overrides
      "/app/views/layouts/decidim/mailer.html.erb" => "23a555f9c674d7db4b0ea6582525e2d6",
      "/app/views/layouts/decidim/newsletter_base.html.erb" => "44095c3df64a4fea34f46b61bb840b31",
      "/app/views/layouts/decidim/footer/_main_links.html.erb" => "2a6361e6b8dbc6a0703892fc2f879fc5", # ephemeral participation overrides
      "/app/views/layouts/decidim/header/_main_links_dropdown.html.erb" => "a369664c2bb36cbd2b10d90d9a7469cf", # ephemeral participation overrides
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "22355fa93da7c8776e7e7f56a5b207f7",
      "/app/cells/decidim/activities_cell.rb" => "d0fa2a5b195fef8e4901cb84470e90a3",
      "/app/cells/decidim/user_profile_cell.rb" => "71216a17c7eea8dd8ebc1ea3907efaef",
      "/lib/decidim/search_resource_fields_mapper.rb" => "3603d17b4a973b57189330a66c58126e",
      "/app/views/layouts/decidim/header/_main.html.erb" => "69acfdeade5dab8cd73e1d19f37fef2c",
      "/app/packs/src/decidim/index.js" => "2c049ec1b8b79c1db50cc2424af0d6f6"
    }
  },
  {
    package: "decidim-assemblies",
    files: {
      "/app/controllers/decidim/assemblies/assemblies_controller.rb" => "c847c0a2170fb75ec12ed5057f4469bd"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/publish_component.rb" => "48b73691b2aea10191ed427702a74359", # revert https://github.com/decidim/decidim/pull/10690
      "/app/commands/decidim/admin/transfer_user.rb" => "7cf11abc98c3a0c4a656ab96c220dd6a", # ephemeral participation overrides
      "/app/forms/decidim/admin/component_form.rb" => "0455dd26580817470fd7096ef6b08315", # ephemeral participation overrides
      "/app/forms/decidim/admin/permissions_form.rb" => "f68d00a490e84524ce3aebe6f71d829a" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/project_vote_button_cell.rb" => "ad12724fc6551354281236cf5a31f973", # ephemeral participation overrides
      "/app/views/decidim/budgets/projects/_project_budget_button.html.erb" => "c81c840fd8487e48ce9f7a985cb88604" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-verifications",
    files: {
      "/app/commands/decidim/verifications/perform_authorization_step.rb" => "aaa4529daa08669a5039b786b97d7d47", # ephemeral participation overrides
      "/app/services/decidim/authorization_handler.rb" => "2431258d1323e9224713c42eb5cf32d6", # ephemeral participation overrides
      "/lib/decidim/verifications/workflow_manifest.rb" => "fa679770a0df3381298e4bc19f6d4e89" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/forms/decidim/system/update_organization_form.rb" => "3fe09b001d83030207a6f5faa256ac3b", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/edit.html.erb" => "01bff555e3d7680868fff210d3c393b2", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/new.html.erb" => "4916cdb428d89de5afe60e279d64112f" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-accountability",
    files: {
      "/app/views/decidim/accountability/admin/results/_form.html.erb" => "980e3f623300704e209f860e1859b507",
      "/app/views/decidim/accountability/admin/results/index.html.erb" => "966e67905bfc82176c7d42dbec855f3e",
      "/app/views/decidim/participatory_spaces/_result.html.erb" => "7565cfff63e0e70bc7286d86bf5b162e",
      "/app/cells/decidim/accountability/result_l/extra_data.erb" => "58368fec1e36bff35cc3ea24c2109076",
      "/app/cells/decidim/accountability/status_cell.rb" => "3916eb7ddb79baa5e20924f296dd707f",
      "/app/cells/decidim/accountability/status/status.erb" => "f9a9e64f6a4c503d6cd8b49cb6f9b197",
      "/app/views/decidim/accountability/results/home.html.erb" => "4050a327e040350e247c9086fc432cde",
      "/app/views/decidim/accountability/results/index.html.erb" => "1b655348f4e689fb27b2892846faf586",
      "/app/views/decidim/accountability/results/_home_categories.html.erb" => "a9b7272f748cc97b17c7cb5fc637639b",
      "/app/views/decidim/accountability/results/_scope_filters.html.erb" => "a405bb47fe4f8f7b216165b5044c1462",
      "/app/models/decidim/accountability/result.rb" => "3c4dc7d6e7cc3b77bb4e1aec061f3559",
      "/app/services/decidim/accountability/results_calculator.rb" => "4cc5ed480220f0bfe7561ad887e59576"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_metadata_g_cell.rb" => "e41380534ae3c4c441530a6739e3746a",
      "/app/models/decidim/initiative.rb" => "a953653617b43ad3a2393ea825bcb154",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "c0f9bf5d9edaca545a7c931c0dc5c0e9",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "bcb89928e3798ec9901b1da5f75919e0"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "f885f36957b27f20535c8d5b985ecee5",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "e1cc26b535c8ee0b1c731219c4d5f121",
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "726b1c957fdadd355171364b3327564a",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "af3b5f11ce074f0328e172fe9dbb57c1",
      "/app/models/decidim/meetings/meeting.rb" => "b8b1b7c84b7eb2e6bca1ff2d93b2f20b",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "80a9327e6c597f590e7a4940b76f7585",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "8be62c6b0cc2f13d4be68eb5e06217de",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "309974a0b89750bbf688589f60c53722"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/helpers/decidim/proposals/application_helper.rb" => "e6039a99268845c5038f913309fde432",
      "/app/presenters/decidim/proposals/proposal_presenter.rb" => "bbc7cee02125c1f8cf909219e48af337"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/views/decidim/forms/admin/questionnaires/answers/show.html.erb" => "addb7272cc1ce5529ec672f9acd346c2",
      "/lib/decidim/forms/user_answers_serializer.rb" => "ff30a5f1c40764837d430b10be8b491e"
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

describe "Overridden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])

    item[:files].each do |file, signature|
      next unless spec

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
