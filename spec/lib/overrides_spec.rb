# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overridden is the same
# as the expected. If this test fails, it means that the overridden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-accountability",
    files: {
      "/app/cells/decidim/accountability/result_l/extra_data.erb" => "58368fec1e36bff35cc3ea24c2109076",
      "/app/cells/decidim/accountability/status/status.erb" => "f9a9e64f6a4c503d6cd8b49cb6f9b197",
      "/app/helpers/decidim/accountability/application_helper.rb" => "3f294bce774933c061c551ea692c8c4c",
      "/app/models/decidim/accountability/result.rb" => "b31a4c94561f0cea7b60ab2d275a8b99",
      "/app/services/decidim/accountability/results_calculator.rb" => "e48030665ab5eb6b313d816f74773cdc",
      "/app/views/decidim/accountability/admin/results/_form.html.erb" => "c625b98e44afa52709281c9722795a45",
      "/app/views/decidim/accountability/admin/results/index.html.erb" => "5593e0c0e8a9a6dd09672ceda2f59e45",
      "/app/views/decidim/accountability/results/_home_taxonomies.html.erb" => "81f24acdee131c85827e08eccd551c22",
      "/app/views/decidim/accountability/results/home.html.erb" => "59a4e334c79fbed14fe83f01efd1372b",
      "/app/views/decidim/accountability/results/index.html.erb" => "09b2a4265c59c0e0ce21b9360a687a01",
      "/app/views/decidim/participatory_spaces/_result.html.erb" => "7565cfff63e0e70bc7286d86bf5b162e"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/publish_component.rb" => "30765306b34a0efa19c9b4ef1cc6f4dc" # revert https://github.com/decidim/decidim/pull/10690
    }
  },
  {
    package: "decidim-assemblies",
    files: {
      "/app/controllers/decidim/assemblies/assemblies_controller.rb" => "92fcbb653e524ac19af32c7be9a73882"
    }
  },
  {
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/budget_list_item_cell.rb" => "987f772cd9d86c707fc378ba698684e4"
    }
  },
  {
    package: "decidim-core",
    files: {
      "/app/controllers/concerns/decidim/paginable.rb" => "a42381a0883c92df189ac61cebea3047", # update per_page method in assemblies_controller_override.rb
      "/app/cells/decidim/activities_cell.rb" => "d0fa2a5b195fef8e4901cb84470e90a3",
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "22355fa93da7c8776e7e7f56a5b207f7",
      "/app/cells/decidim/user_profile_cell.rb" => "71216a17c7eea8dd8ebc1ea3907efaef",
      "/app/helpers/decidim/paginate_helper.rb" => "d7a08fda6fff5c0e43fbea2a83cd5346",
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "be1d2c978a80cca492954666677cd4bd",
      "/app/views/layouts/decidim/header/_main.html.erb" => "2cda0f82a0ac644c1ba89f84d5c60b97",
      "/app/views/layouts/decidim/mailer.html.erb" => "23a555f9c674d7db4b0ea6582525e2d6",
      "/app/views/layouts/decidim/newsletter_base.html.erb" => "44095c3df64a4fea34f46b61bb840b31",
      "/lib/decidim/search_resource_fields_mapper.rb" => "3603d17b4a973b57189330a66c58126e"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "0036e31fa16df5c13bc36090bfbad17d",
      "/app/views/decidim/forms/admin/questionnaires/answers/show.html.erb" => "addb7272cc1ce5529ec672f9acd346c2",
      "/lib/decidim/forms/user_answers_serializer.rb" => "ff30a5f1c40764837d430b10be8b491e"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_metadata_g_cell.rb" => "e41380534ae3c4c441530a6739e3746a",
      "/app/models/decidim/initiative.rb" => "8b6a205a8b83cf0501e989f70a5aed4a",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "b26494f17e65d164822b03e912dfe9e7",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "bcb89928e3798ec9901b1da5f75919e0",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/lib/decidim/exporters/initiative_votes_pdf.rb" => "e71f75f2cf1dc508fd8ccee37254c5c1"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "726b1c957fdadd355171364b3327564a",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "e1cc26b535c8ee0b1c731219c4d5f121",
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "aedb2460af3d4a7de566ddf27b60109e",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "af3b5f11ce074f0328e172fe9dbb57c1",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "deb84fa4e285297a6d3e0d60490a84eb",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "f22784223bb7486da03ae89efc2314a0",
      "/app/models/decidim/meetings/meeting.rb" => "117dc0dffc7e44598edc4ae63e92f0e8",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "309974a0b89750bbf688589f60c53722"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/helpers/decidim/proposals/application_helper.rb" => "e539b6feb12c515ec24ed6d3efd6e29e",
      "/app/presenters/decidim/proposals/proposal_presenter.rb" => "b12cfb5e55aff4756d757e71e580c547"
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/cells/decidim/system/system_checks_cell.rb" => "42e1b5525b5a9df1705cae3ef29ad9c4",
      "/app/forms/decidim/system/base_organization_form.rb" => "b580ac7e687f288c8f27b82d67cdc99d"
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
