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
      "/app/models/decidim/accountability/result.rb" => "bb890c4d83a1a0a80367781445d4ff11",
      "/app/services/decidim/accountability/results_calculator.rb" => "e48030665ab5eb6b313d816f74773cdc",
      "/app/views/decidim/accountability/admin/results/_form.html.erb" => "1afbe7a56cada69eac1c52073df1a0fc",
      "/app/views/decidim/accountability/admin/results/index.html.erb" => "50080eca9bc6c3852016c11c97faa1d2",
      "/app/views/decidim/accountability/results/_home_aside.html.erb" => "a74de3e38a3c1bc94f677cb23d29385b",
      "/app/views/decidim/accountability/results/_one_level_taxonomies.html.erb" => "3285460a675f13d5db1fbe0a39a155fd",
      "/app/views/decidim/accountability/results/_two_levels_taxonomies.html.erb" => "47b46188786d8ba654ecdba1ab996ebe",
      "/app/views/decidim/participatory_spaces/_result.html.erb" => "7565cfff63e0e70bc7286d86bf5b162e"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/publish_component.rb" => "4aea28b33468227392384324a3845b2e", # revert https://github.com/decidim/decidim/pull/10690
      "/app/controllers/concerns/decidim/admin/filterable.rb" => "3c54a6066a60af9fd079dfe18d97c40f", # filtered_collection replaced in admin/assemblies_controller_override.rb, backport https://github.com/decidim/decidim/pull/17500
      "/app/views/decidim/admin/resource_permissions/_options_form.html.erb" => "995160c04f1cd0173e4bfb2d690bacbd",
      "/app/views/decidim/admin/resource_permissions/edit.html.erb" => "142629c45195cfa36dc5a4350aac6a7f"
    }
  },
  {
    package: "decidim-assemblies",
    files: {
      "/app/controllers/decidim/assemblies/admin/assemblies_controller.rb" => "2e7ae7ed6406facce95e8819ae6e0a79", # show all children in admin list, backport https://github.com/decidim/decidim/pull/17500
      "/app/controllers/decidim/assemblies/assemblies_controller.rb" => "92fcbb653e524ac19af32c7be9a73882"
    }
  },
  {
    package: "decidim-core",
    files: {
      "/app/cells/decidim/activities_cell.rb" => "d0fa2a5b195fef8e4901cb84470e90a3",
      "/app/cells/decidim/content_blocks/html_cell.rb" => "67df12cd1caefa3a8ddb7d340dcd057f", # revert sanitization from CVE-2026-45572 to allow JavaScript
      "/app/cells/decidim/content_blocks/last_activity_cell.rb" => "1133508a27279abcc0871f25d6ac3bd8",
      "/app/cells/decidim/user_profile_cell.rb" => "0f20d006ccf4df77c59e3a2333a28a10",
      "/app/controllers/concerns/decidim/paginable.rb" => "a42381a0883c92df189ac61cebea3047", # update per_page method in assemblies_controller_override.rb
      "/app/helpers/decidim/paginate_helper.rb" => "bdedfc156661546c73ab428ebb139e8a",
      "/app/packs/stylesheets/decidim/legacy/email.scss" => "7edc1be320cdd9605bec4e0caba132d5",
      "/app/presenters/decidim/official_author_presenter.rb" => "dbfb2fefa1c75d703e65443cd68014c2",
      "/app/views/layouts/decidim/footer/_main_legal.html.erb" => "d4d3e477b5eb6840b915a836b1a7f417",
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "c67cc97db27cdcf926f60682e399f688",
      "/app/views/layouts/decidim/header/_main.html.erb" => "2808459045fd14b7f8d689fbbd6dfa4e",
      "/app/views/layouts/decidim/mailer.html.erb" => "6a08103c75e5db737a38cd365428a177",
      "/app/views/layouts/decidim/newsletter_base.html.erb" => "28111c73d348ec8d1cdc1180d3ff5d21",
      "/lib/decidim/search_resource_fields_mapper.rb" => "b0e0b9f28304241a0f2d6742a6460821"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/models/decidim/forms/question.rb" => "92531f8217998320bfae5ac4d5f8e7e8", # fix display_conditions_for_other_questions inverse_of in question_override.rb
      "/app/queries/decidim/forms/questionnaire_user_responses.rb" => "d9a56ef2b9b1e06040143272adf8d7d0",
      "/app/views/decidim/forms/admin/questionnaires/responses/show.html.erb" => "1e47e22c0b715e870b54421bf250bef8",
      "/lib/decidim/forms/user_responses_serializer.rb" => "71762d1083ba1bdf4c0acd44a0cc7371"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_metadata_g_cell.rb" => "e41380534ae3c4c441530a6739e3746a",
      "/app/commands/decidim/initiatives/admin/update_initiative.rb" => "951ffea897cc47bae5a2bfc7952ac0d3",
      "/app/commands/decidim/initiatives/create_initiative.rb" => "9235f42166d1be00314c633812eeed2e",
      "/app/commands/decidim/initiatives/update_initiative.rb" => "fcee3478de665f6b505df682b6d2ad07",
      "/app/forms/decidim/initiatives/admin/initiative_form.rb" => "1bec52ba9fda0b68c5c7ece3bc0a1b08",
      "/app/forms/decidim/initiatives/initiative_form.rb" => "b20b9aa28b1a3ecac27e0d3915f5b13b",
      "/app/models/decidim/initiative.rb" => "aa232a88c8656fc3f98a1466939bdff7",
      "/app/models/decidim/initiatives_vote.rb" => "f94e485caed75a2938781eb66541fb56",
      "/app/permissions/decidim/initiatives/admin/permissions.rb" => "54a861b5666c067fc14a800358957620",
      "/app/serializers/decidim/initiatives/open_data_initiative_serializer.rb" => "5e213e9ad04444b4ed9495be7fdcdfc9",
      "/app/views/decidim/initiatives/admin/answers/_info_initiative.html.erb" => "103183460a6692bda31b7b7c46e6b677",
      "/app/views/decidim/initiatives/admin/initiatives/_form.html.erb" => "38094b4cc81a0c2fb8cfd0c641a40bb7",
      "/app/views/decidim/initiatives/committee_requests/new.html.erb" => "fc12e7384f966b29e90c3b7e46d33f8d",
      "/app/views/decidim/initiatives/create_initiative/fill_data.html.erb" => "085d3c9cd67eb06f2bcf3a5285f09168",
      "/app/views/decidim/initiatives/initiatives/_form.html.erb" => "d52fcbfa2a682b57fa4ab3be9aa7dc3a",
      "/app/views/decidim/initiatives/initiatives/_progress_bar.html.erb" => "849e1ad297a15bb00e34122d3b845ff9",
      "/app/views/decidim/initiatives/initiatives/show.html.erb" => "f7f97b517d429eab978a205f20df188d",
      "/lib/decidim/exporters/initiative_votes_pdf.rb" => "3c68da5b72db76322cbef28ce9452299",
      "/lib/decidim/initiatives/application_form_pdf.rb" => "3aa6f0d51983542b63e013cba48b5a1f"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/cells/decidim/meetings/online_meeting_cell.rb" => "d81e79f8308ae7800b358c040524ea72",
      "/app/cells/decidim/meetings/online_meeting_link/show.erb" => "e1cc26b535c8ee0b1c731219c4d5f121",
      "/app/cells/decidim/meetings/join_meeting_button/show.erb" => "dba7e8b77e04abfe953e0a312b9106f1",
      "/app/cells/decidim/meetings/join_meeting_button_cell.rb" => "6dcb71229b789b7ceef2736c2322fc7c",
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "289c2d32078ba889af6e5bdf68bddc47",
      "/app/helpers/decidim/meetings/meetings_helper.rb" => "7f393c50d7a01bc24f6a3d08d5590e10",
      "/app/models/decidim/meetings/meeting.rb" => "eaeb66d61b1a2db5b69dc20bf25167d5",
      "/app/views/decidim/meetings/meetings/_meeting_agenda.html.erb" => "3d0a04c264dd2c88212789e0e5bc803b",
      # Delete this once we are using the version with this PR: https://github.com/decidim/decidim/pull/17342 and remove all the changes included in this PR: https://github.com/AjuntamentdeBarcelona/decidim-barcelona/pull/750
      "/lib/decidim/meetings/component.rb" => "cd3061f1336476f26f6c7d90153653de"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/helpers/decidim/proposals/application_helper.rb" => "8d4f7a7598f10f1b6123533bee8fbd3a",
      "/app/presenters/decidim/proposals/proposal_presenter.rb" => "400df0fffc5fa1b52ef09344409d5c78"
    }
  },
  {
    package: "decidim-verifications",
    files: {
      "/app/controllers/decidim/verifications/authorizations_controller.rb" => "41f6899dc28e9f987a0d437e5aa25daf"
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/cells/decidim/system/system_checks_cell.rb" => "42e1b5525b5a9df1705cae3ef29ad9c4",
      "/app/controllers/decidim/system/dashboard_controller.rb" => "558a911b6805540a360ec65aa9df1ad0",
      "/app/forms/decidim/system/base_organization_form.rb" => "a2fc393197f1a0a42144fc79455a9278",
      "/app/views/decidim/system/dashboard/show.html.erb" => "a125b7d7dbdcb2bbf0e4292baa8e3c33"
    }
  }
]

describe "Overridden files", type: :view do
  checksums.each do |item|
    gem_spec = Gem::Specification.find_by_name(item[:package])
    next unless gem_spec

    item[:files].each do |file, signature|
      # gem_dir is interpolated into the example name at definition time, but the example
      # body re-resolves it so no outer local variable leaks in (RSpec/LeakyLocalVariable).
      it "#{gem_spec.gem_dir}#{file} matches checksum" do
        gem_dir = Gem::Specification.find_by_name(item[:package]).gem_dir
        expect(md5("#{gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
