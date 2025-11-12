# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overridden is the same
# as the expected. If this test fails, it means that the overridden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/helpers/decidim/paginate_helper.rb" => "d7a08fda6fff5c0e43fbea2a83cd5346",
      "/app/controllers/concerns/decidim/paginable.rb" => "a42381a0883c92df189ac61cebea3047", # update per_page method in assemblies_controller_override.rb
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "be1d2c978a80cca492954666677cd4bd",
      "/app/views/layouts/decidim/mailer.html.erb" => "23a555f9c674d7db4b0ea6582525e2d6",
      "/app/views/layouts/decidim/newsletter_base.html.erb" => "44095c3df64a4fea34f46b61bb840b31",
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "22355fa93da7c8776e7e7f56a5b207f7",
      "/app/cells/decidim/activities_cell.rb" => "d0fa2a5b195fef8e4901cb84470e90a3",
      "/app/cells/decidim/user_profile_cell.rb" => "71216a17c7eea8dd8ebc1ea3907efaef",
      "/lib/decidim/search_resource_fields_mapper.rb" => "3603d17b4a973b57189330a66c58126e",
      "/app/views/layouts/decidim/header/_main.html.erb" => "f5cb633c39af336c6fa131063bcffcbc",
      "/app/packs/src/decidim/index.js" => "d7af2c172c08220f50fe327d73ab33d9",
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "c67cc97db27cdcf926f60682e399f688"
    }
  },
  {
    package: "decidim-assemblies",
    files: {
      "/app/controllers/decidim/assemblies/assemblies_controller.rb" => "7f8d8b3d38fa0f4b0a83a8012083ce71"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/publish_component.rb" => "48b73691b2aea10191ed427702a74359" # revert https://github.com/decidim/decidim/pull/10690
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/cells/decidim/system/system_checks_cell.rb" => "b59c845eb450b08ae9bed94260d1b2e7",
      "/app/forms/decidim/system/base_organization_form.rb" => "711d78632492cf9fd7b3356f38b9ba72"
    }
  },
  {
    package: "decidim-accountability",
    files: {
      "/app/helpers/decidim/accountability/application_helper.rb" => "944e9a9bfc994c4b4018f3171aeb0a4c",
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
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/budget_list_item_cell.rb" => "086a72c42f94639fdb3ad68fa6dbcc3c"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives_votes/vote/show.erb" => "ab0c6d849c32ed9a76037587492f85f1",
      "/app/cells/decidim/initiatives_votes/vote_cell.rb" => "53ee774d8284581cdd481718ae35003e",
      "/app/views/decidim/initiatives/admin/initiatives/_signatures.html.erb" => "a57884ead149d3c455aa1037df715791",
      "/app/cells/decidim/initiatives/initiative_metadata_g_cell.rb" => "e41380534ae3c4c441530a6739e3746a",
      "/app/models/decidim/initiative.rb" => "fdd677eea29010a1afec3374b2fde5fc",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "c0f9bf5d9edaca545a7c931c0dc5c0e9",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "bcb89928e3798ec9901b1da5f75919e0"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "74c0fd04cfedb32371e21e47b60d7afb",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "e1cc26b535c8ee0b1c731219c4d5f121",
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "726b1c957fdadd355171364b3327564a",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "af3b5f11ce074f0328e172fe9dbb57c1",
      "/app/models/decidim/meetings/meeting.rb" => "b5bb8624a4e9bac66a9e6a9d9b64ae63",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "f840590ead8c29c4c6fa6f9ad7d6e2e0",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "8be62c6b0cc2f13d4be68eb5e06217de",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "309974a0b89750bbf688589f60c53722"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/cells/decidim/proposals/proposal_g_cell.rb" => "114f112b90eebae433e50950f2691d6c",
      "/app/cells/decidim/proposals/proposal_l_cell.rb" => "4743525d9b89e27aa356636c6e256a84",
      "/app/helpers/decidim/proposals/application_helper.rb" => "05c7005840dd4b6b6269e7d0c9e7a507",
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
