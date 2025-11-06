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
      "/app/controllers/concerns/decidim/paginable.rb" => "a42381a0883c92df189ac61cebea3047", # update per_page method in assemblies_controller_override.rb
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "be1d2c978a80cca492954666677cd4bd",
      "/app/views/layouts/decidim/mailer.html.erb" => "23a555f9c674d7db4b0ea6582525e2d6",
      "/app/views/layouts/decidim/newsletter_base.html.erb" => "44095c3df64a4fea34f46b61bb840b31",
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "22355fa93da7c8776e7e7f56a5b207f7",
      "/app/cells/decidim/activities_cell.rb" => "d0fa2a5b195fef8e4901cb84470e90a3",
      "/app/cells/decidim/user_profile_cell.rb" => "71216a17c7eea8dd8ebc1ea3907efaef",
      "/lib/decidim/search_resource_fields_mapper.rb" => "3603d17b4a973b57189330a66c58126e",
      "/app/views/layouts/decidim/header/_main.html.erb" => "c4f48e1064175113c72be021c8c56d33",
      "/app/packs/src/decidim/index.js" => "5f60cf5f726fa44b1f6130f296790045"
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
      "/app/models/decidim/initiative.rb" => "2e462e69b8a2437c9ea8cc9689764a12",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "c0f9bf5d9edaca545a7c931c0dc5c0e9",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "bcb89928e3798ec9901b1da5f75919e0",
      "/app/forms/decidim/initiatives/initiative_form.rb" => "c7fbfb87345216a9f7fd8f1e76f8890e",
      "/app/forms/decidim/initiatives/admin/initiative_form.rb" => "c77010966ee37688745535d8ac4b3f37",
      "/app/commands/decidim/initiatives/create_initiative.rb" => "f191bae5b5cbcd59fcf70058fac6bd6d",
      "/app/commands/decidim/initiatives/update_initiative.rb" => "40893a128dd04508d7a506f1f5415bdd",
      "/app/commands/decidim/initiatives/admin/update_initiative.rb" => "b710c8451fba4cf1bb199488b94680b0",
      "/app/serializers/decidim/initiatives/initiative_serializer.rb" => "eaff0cb9ef0b0d191ad959236b61fd3f",
      "/app/views/decidim/initiatives/initiatives/show.html.erb" => "156550250f72e53d3dcce1d2a57a8750",
      "/app/views/decidim/initiatives/initiatives/_form.html.erb" => "3132bef2e64bfb6efc9035320c562d3e",
      "/app/views/decidim/initiatives/initiatives/print.html.erb" => "fb8432d1af36bcc8bfa0e2b46c78c236",
      "/app/views/decidim/initiatives/admin/initiatives/_form.html.erb" => "2b76ff0df854bf15b2e6f33107f8eb6a",
      "/app/views/decidim/initiatives/admin/answers/_info_initiative.html.erb" => "103183460a6692bda31b7b7c46e6b677",
      "/app/views/decidim/initiatives/committee_requests/new.html.erb" => "199506bee071e88185f8c0776932d87f",
      "/app/views/decidim/initiatives/create_initiative/fill_data.html.erb" => "f17f2ce5f48524d5c6c0e444247e50e1",
      "/app/views/decidim/initiatives/create_initiative/promotal_committee.html.erb" => "6f818bbdbaae0618eb24bed287cf1203",
      "/app/models/decidim/initiatives_vote.rb" => "1842a9fcb559d749df116a8fc4eb4f46"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "74c0fd04cfedb32371e21e47b60d7afb",
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
