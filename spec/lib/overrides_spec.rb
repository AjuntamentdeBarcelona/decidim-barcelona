# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/application_controller.rb" => "b9816a58ec4c5b45f747c27460f17018", # ephemeral participation overrides
      "/app/helpers/decidim/decidim_form_helper.rb" => "0c6b26cee8e54a5c2bc93256286b6f26", # ephemeral participation overrides
      "/app/models/decidim/component.rb" => "32e241f1d88313e487cd28daac09aee0", # ephemeral participation overrides
      "/app/models/decidim/organization.rb" => "e0b67b906f0ad3db84226914f07a05e7", # ephemeral participation overrides
      "/app/models/decidim/permission_action.rb" => "00da630bf229dc8d482dc0e0b2d6a95c", # ephemeral participation overrides
      "/app/models/decidim/user.rb" => "2b0e4abef9f8ac3bc3b7bba735420cee", # ephemeral participation overrides
      "/app/permissions/decidim/permissions.rb" => "ace85e448814ed71bbea5e7515b95d5d", # ephemeral participation overrides
      "/app/views/decidim/shared/_login_modal.html.erb" => "bf583a391dc1cc50fc8261dd850dfcc1", # ephemeral participation overrides
      "/app/views/layouts/decidim/mailer.html.erb" => "0c7804de08649c8d3c55c117005e51c9",
      "/app/views/layouts/decidim/_user_menu.html.erb" => "de17337bd45f6e6d5aa455267f70430f", # ephemeral participation overrides
      "/app/views/layouts/decidim/widget.html.erb" => "b9fb503118ee33d298cbc585995e216c"
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
      "/app/forms/decidim/system/update_organization_form.rb" => "b28ece5dbf3e227bc5b510886af567e2", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/edit.html.erb" => "a5fbf0df2106009878cbca6e36472cae", # ephemeral participation overrides
      "/app/views/decidim/system/organizations/new.html.erb" => "ef9277c31e87f864e911a05d7ad0a333" # ephemeral participation overrides
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
      "/app/views/layouts/decidim/_initiative_header_steps.html.erb" => "b82f930fafd65df4170f8a6ffc7595bd",
      "/app/views/decidim/initiatives/initiative_signatures/fill_personal_data.html.erb" => "2c3068724ed2986f62bd13994960f39e"
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
