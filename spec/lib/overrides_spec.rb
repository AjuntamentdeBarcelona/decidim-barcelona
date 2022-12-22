# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/application_controller.rb" => "29be8e89dac380b4b60afd593e15ad77", # ephemeral participation overrides
      "/app/helpers/decidim/decidim_form_helper.rb" => "19fcf923fdb56346b21c151f68f7cce7", # ephemeral participation overrides
      "/app/models/decidim/component.rb" => "32e241f1d88313e487cd28daac09aee0", # ephemeral participation overrides
      "/app/models/decidim/organization.rb" => "4d1f1e1881dbde53e8252b0b9b321fa7", # ephemeral participation overrides
      "/app/models/decidim/permission_action.rb" => "bbcc850ba2287bbcecee54ddc8357202", # ephemeral participation overrides
      "/app/models/decidim/user.rb" => "4aff1b94255db5ffa8868a0f2876c14f", # ephemeral participation overrides
      "/app/permissions/decidim/permissions.rb" => "77d2e82aa18e393ea8a7490a44ed9ebf", # ephemeral participation overrides
      "/app/views/decidim/shared/_login_modal.html.erb" => "bf583a391dc1cc50fc8261dd850dfcc1", # ephemeral participation overrides
      "/app/views/layouts/decidim/mailer.html.erb" => "0c7804de08649c8d3c55c117005e51c9",
      "/app/views/layouts/decidim/_user_menu.html.erb" => "de17337bd45f6e6d5aa455267f70430f", # ephemeral participation overrides
      "/app/views/layouts/decidim/widget.html.erb" => "c1597f7a98b4f5a2fecca26022529339"
    }
  },
  {
    package: "decidim-admin",
    files: {
      "/app/commands/decidim/admin/transfer_user.rb" => "b4c4808c0ffd4215cd2bddeefd87201a", # ephemeral participation overrides
      "/app/controllers/decidim/admin/conflicts_controller.rb" => "dfe4daf8dcb7b4963e37651b0fe8df3c", # ephemeral participation overrides
      "/app/forms/decidim/admin/component_form.rb" => "c44e97d9f4a18a8692079e9ab993c418", # ephemeral participation overrides
      "/app/forms/decidim/admin/permissions_form.rb" => "716cf7f4bffc06d03a462c77932999fd" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-budgets",
    files: {
      "/app/cells/decidim/budgets/project_list_item_cell.rb" => "dfcda04b9fe17de547a0bf25c6bbf823", # ephemeral participation overrides
      "/app/views/decidim/budgets/projects/_project_budget_button.html.erb" => "61b9a76dec62adb19ba36d2c2eb67e0c" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-verifications",
    files: {
      "/app/commands/decidim/verifications/perform_authorization_step.rb" => "0c5a5800019a4c159c70175ce8ed17c1", # ephemeral participation overrides
      "/app/services/decidim/authorization_handler.rb" => "36c5cf48c9163677373439f6d2617afa", # ephemeral participation overrides
      "/lib/decidim/verifications/workflow_manifest.rb" => "eb40ba8ed4b282ffe22158521dcf0499" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-system",
    files: {
      "/app/forms/decidim/system/update_organization_form.rb" => "a3238f4108c8be5cf0dc3e9dad711ad6", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/edit.html.erb" => "a5fbf0df2106009878cbca6e36472cae", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/new.html.erb" => "ef9277c31e87f864e911a05d7ad0a333" # ephemeral participation overrides
    }
  },
  {
    package: "decidim-accountability",
    files: {
      "/app/views/decidim/accountability/results/home.html.erb" => "8b8b5073f77299f1f594ca7229874963",
      "/app/models/decidim/accountability/result.rb" => "1d2429c8a7186153e8e53afeadfc8363",
      "/app/services/decidim/accountability/results_calculator.rb" => "2a8e80a63bdc35fad9e4c4cc52cb9e28",
      "/app/views/decidim/accountability/results/_results_leaf.html.erb" => "37bec8d75287a59f7cb16140ec2678db",
      "/app/views/decidim/accountability/results/_show_leaf.html.erb" => "7c99f542c9cb2ef72dbe2f86e285bd26"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/cells/decidim/initiatives/initiative_m_cell.rb" => "a20b707d0533dd8883b0bdbf8bc0b2c0",
      "/app/views/layouts/decidim/_initiative_header_steps.html.erb" => "f1bcd3e7c406a2263d49d0f341930bfc"
    }
  },
  {
    package: "decidim-term_customizer",
    files: {
      "/lib/decidim/term_customizer/context/controller_context.rb" => "8cb312927aa94dac899ecb7bfcf2a9d2"
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
