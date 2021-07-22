# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/application_controller.rb" => "f4fca096327c8c0f32914797baf46b02",
      "/app/helpers/decidim/decidim_form_helper.rb" => "e223839a485c177b26f39ab179571319",
      "/app/models/decidim/component.rb" => "32e241f1d88313e487cd28daac09aee0",
      "/app/models/decidim/organization.rb" => "c3ff5577629b71676dc1cfb70289149a",
      "/app/models/decidim/permission_action.rb" => "bbcc850ba2287bbcecee54ddc8357202",
      "/app/models/decidim/user.rb" => "83af6296e9aab00d3bfcb5f85fff9ed4",
      "/app/permissions/decidim/permissions.rb" => "c65979f3e51b5756c298617ae5590bf7",
      "/app/views/decidim/shared/_login_modal.html.erb" => "03836c23b2e46863caa183b52a14aa4c",
      "/app/views/layouts/decidim/_user_menu.html.erb" => "3eaf7667acc1603e7f590b674a7dbe89"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/transfer_user.rb" => "b4c4808c0ffd4215cd2bddeefd87201a",
      "/app/controllers/decidim/admin/conflicts_controller.rb" => "9238771a6342acddc2f046fc957434e7",
      "/app/forms/decidim/admin/component_form.rb" => "c44e97d9f4a18a8692079e9ab993c418",
      "/app/forms/decidim/admin/permissions_form.rb" => "716cf7f4bffc06d03a462c77932999fd"
    }
  },
  {
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/project_list_item_cell.rb" => "50a85154d1ca348fae42c85d888e856b",
      "/app/views/decidim/budgets/projects/_project_budget_button.html.erb" => "996793f2c00f29d18a6f9cda2ea1b5ed"
    }
  },
  {
    package: "decidim-verifications",
    files: {
      "/app/commands/decidim/verifications/perform_authorization_step.rb" => "0c5a5800019a4c159c70175ce8ed17c1",
      "/app/services/decidim/authorization_handler.rb" => "36c5cf48c9163677373439f6d2617afa",
      "/lib/decidim/verifications/workflow_manifest.rb" => "eb40ba8ed4b282ffe22158521dcf0499"
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/forms/decidim/system/update_organization_form.rb" => "a3238f4108c8be5cf0dc3e9dad711ad6",
      "/app/views/decidim/system/organizations/edit.html.erb" => "d8b64269ccd0344e0e00590d565105d0",
      "/app/views/decidim/system/organizations/new.html.erb" => "e584b6f3e86c0e6e7468b8346e2299c9"
    }
  }
]

describe "Overriden files", type: :view do
  # rubocop:disable Rails/DynamicFindBy
  checksums.each do |item|
    spec = ::Gem::Specification.find_by_name(item[:package])

    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end
  # rubocop:enable Rails/DynamicFindBy

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
