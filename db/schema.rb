# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_29_103257) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "ltree"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "active_hashcash_stamps", force: :cascade do |t|
    t.integer "bits", null: false
    t.jsonb "context"
    t.string "counter", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "date", null: false
    t.string "ext", null: false
    t.string "ip_address"
    t.string "rand", null: false
    t.string "request_path"
    t.string "resource", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "version", null: false
    t.index ["counter", "rand", "date", "resource", "bits", "version", "ext"], name: "index_active_hashcash_stamps_unique", unique: true
    t.index ["ip_address", "created_at"], name: "index_active_hashcash_stamps_on_ip_address_and_created_at", where: "(ip_address IS NOT NULL)"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "decidim_accountability_milestones", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_accountability_result_id"
    t.jsonb "description"
    t.date "entry_date"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_accountability_result_id"], name: "index_decidim_accountability_milestones_on_results_id"
  end

  create_table "decidim_accountability_results", id: :serial, force: :cascade do |t|
    t.text "address"
    t.integer "children_count", default: 0
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_accountability_status_id"
    t.integer "decidim_component_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.date "end_date"
    t.string "external_id"
    t.float "latitude"
    t.integer "legacy_id"
    t.float "longitude"
    t.integer "parent_id"
    t.decimal "progress", precision: 5, scale: 2
    t.string "reference"
    t.date "start_date"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.float "weight", default: 1.0
    t.index ["decidim_accountability_status_id"], name: "decidim_accountability_results_on_status_id"
    t.index ["decidim_component_id", "external_id"], name: "decidim_accountability_results_on_external_id", unique: true
    t.index ["decidim_component_id"], name: "index_decidim_accountability_results_on_decidim_component_id"
    t.index ["decidim_scope_id"], name: "index_decidim_accountability_results_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_accountability_results_on_deleted_at"
    t.index ["external_id"], name: "index_decidim_accountability_results_on_external_id"
    t.index ["parent_id"], name: "decidim_accountability_results_on_parent_id"
  end

  create_table "decidim_accountability_statuses", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_component_id"
    t.jsonb "description"
    t.string "key"
    t.jsonb "name"
    t.integer "progress"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_component_id"], name: "index_decidim_accountability_statuses_on_decidim_component_id"
  end

  create_table "decidim_action_logs", force: :cascade do |t|
    t.string "action", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_area_id"
    t.bigint "decidim_component_id"
    t.bigint "decidim_organization_id", null: false
    t.integer "decidim_scope_id"
    t.jsonb "extra"
    t.bigint "participatory_space_id"
    t.string "participatory_space_type"
    t.bigint "resource_id", null: false
    t.string "resource_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.string "user_type", default: "Decidim::User", null: false
    t.integer "version_id"
    t.string "visibility", default: "admin-only"
    t.index ["created_at"], name: "index_decidim_action_logs_on_created_at"
    t.index ["decidim_area_id"], name: "index_decidim_action_logs_on_decidim_area_id"
    t.index ["decidim_component_id"], name: "index_action_logs_on_component_id"
    t.index ["decidim_organization_id"], name: "index_action_logs_on_organization_id"
    t.index ["decidim_scope_id"], name: "index_decidim_action_logs_on_decidim_scope_id"
    t.index ["participatory_space_type", "participatory_space_id"], name: "index_action_logs_on_space_type_and_id"
    t.index ["resource_type", "resource_id"], name: "index_action_logs_on_resource_type_and_id"
    t.index ["user_id", "user_type"], name: "index_decidim_action_log_on_users"
    t.index ["user_id"], name: "index_action_logs_on_user_id"
    t.index ["version_id"], name: "index_decidim_action_logs_on_version_id"
    t.index ["visibility"], name: "index_decidim_action_logs_on_visibility"
  end

  create_table "decidim_amendments", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_amendable_id"
    t.string "decidim_amendable_type"
    t.bigint "decidim_emendation_id"
    t.string "decidim_emendation_type"
    t.bigint "decidim_user_id", null: false
    t.integer "state", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_amendable_id", "decidim_amendable_type"], name: "index_on_amendable"
    t.index ["decidim_emendation_id"], name: "index_decidim_amendments_on_decidim_emendation_id"
    t.index ["decidim_user_id", "decidim_amendable_id", "decidim_amendable_type"], name: "index_on_amender_and_amendable"
    t.index ["decidim_user_id"], name: "index_decidim_amendments_on_decidim_user_id"
  end

  create_table "decidim_api_jwt_denylists", force: :cascade do |t|
    t.datetime "exp", null: false
    t.string "jti", null: false
    t.index ["jti"], name: "index_decidim_api_jwt_denylists_on_jti"
  end

  create_table "decidim_area_types", force: :cascade do |t|
    t.bigint "decidim_organization_id"
    t.jsonb "name", null: false
    t.jsonb "plural", null: false
    t.index ["decidim_organization_id"], name: "index_decidim_area_types_on_decidim_organization_id"
  end

  create_table "decidim_areas", force: :cascade do |t|
    t.bigint "area_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_organization_id"
    t.jsonb "name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["area_type_id"], name: "index_decidim_areas_on_area_type_id"
    t.index ["decidim_organization_id"], name: "index_decidim_areas_on_decidim_organization_id"
  end

  create_table "decidim_assemblies", id: :serial, force: :cascade do |t|
    t.integer "access_mode", default: 0, null: false
    t.jsonb "announcement"
    t.integer "children_count", default: 0
    t.date "closing_date"
    t.jsonb "closing_date_reason"
    t.jsonb "composition"
    t.datetime "created_at", precision: nil, null: false
    t.string "created_by"
    t.jsonb "created_by_other"
    t.date "creation_date"
    t.bigint "decidim_area_id"
    t.integer "decidim_organization_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description", null: false
    t.jsonb "developer_group"
    t.date "duration"
    t.string "facebook_handler"
    t.integer "follows_count", default: 0, null: false
    t.string "github_handler"
    t.boolean "has_members", default: false
    t.date "included_at"
    t.string "instagram_handler"
    t.jsonb "internal_organisation"
    t.boolean "is_transparent", default: true
    t.jsonb "local_area"
    t.jsonb "meta_scope"
    t.bigint "parent_id"
    t.ltree "parents_path"
    t.jsonb "participatory_scope"
    t.jsonb "participatory_structure"
    t.boolean "private_space", default: false
    t.boolean "promoted", default: false
    t.datetime "published_at", precision: nil
    t.jsonb "purpose_of_action"
    t.string "reference"
    t.boolean "scopes_enabled", default: true, null: false
    t.jsonb "short_description", null: false
    t.string "slug", null: false
    t.jsonb "special_features"
    t.jsonb "subtitle", null: false
    t.jsonb "target"
    t.jsonb "title", null: false
    t.string "twitter_handler"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 1, null: false
    t.string "youtube_handler"
    t.index ["decidim_area_id"], name: "index_decidim_assemblies_on_decidim_area_id"
    t.index ["decidim_organization_id", "slug"], name: "index_unique_assembly_slug_and_organization", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_assemblies_on_decidim_organization_id"
    t.index ["decidim_scope_id"], name: "index_decidim_assemblies_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_assemblies_on_deleted_at"
    t.index ["parent_id"], name: "decidim_assemblies_assemblies_on_parent_id"
  end

  create_table "decidim_assemblies_settings", force: :cascade do |t|
    t.bigint "decidim_organization_id"
    t.boolean "enable_organization_chart", default: true
    t.index ["decidim_organization_id"], name: "index_decidim_assemblies_settings_on_decidim_organization_id"
  end

  create_table "decidim_assembly_members", force: :cascade do |t|
    t.date "birthday"
    t.string "birthplace"
    t.date "ceased_date"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_assembly_id"
    t.bigint "decidim_user_id"
    t.date "designation_date"
    t.string "full_name"
    t.string "gender"
    t.string "position"
    t.string "position_other"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_assembly_id"], name: "index_decidim_assembly_members_on_decidim_assembly_id"
    t.index ["decidim_user_id"], name: "index_decidim_assembly_members_on_decidim_user_id"
    t.index ["weight", "created_at"], name: "index_decidim_assembly_members_on_weight_and_created_at"
  end

  create_table "decidim_assembly_user_roles", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_assembly_id"
    t.integer "decidim_user_id"
    t.string "role"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_assembly_id", "decidim_user_id", "role"], name: "index_unique_user_and_assembly_role", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_assembly_user_roles_on_decidim_user_id"
  end

  create_table "decidim_attachment_collections", force: :cascade do |t|
    t.bigint "collection_for_id", null: false
    t.string "collection_for_type", null: false
    t.jsonb "description", null: false
    t.jsonb "name", null: false
    t.integer "weight", default: 0, null: false
    t.index ["collection_for_type", "collection_for_id"], name: "decidim_attachment_collections_collection_for_id_and_type"
  end

  create_table "decidim_attachments", id: :serial, force: :cascade do |t|
    t.integer "attached_to_id", null: false
    t.string "attached_to_type", null: false
    t.integer "attachment_collection_id"
    t.string "content_type", null: false
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "description"
    t.string "file_size", null: false
    t.string "link"
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["attached_to_id", "attached_to_type"], name: "index_decidim_attachments_on_attached_to"
    t.index ["attachment_collection_id"], name: "index_decidim_attachments_on_attachment_collection_id"
  end

  create_table "decidim_authorization_transfer_records", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "resource_id", null: false
    t.string "resource_type", null: false
    t.bigint "transfer_id", null: false
    t.index ["resource_type", "resource_id"], name: "index_decidim_authorization_transfer_records_on_resource"
    t.index ["transfer_id"], name: "index_decidim_authorization_transfer_records_on_transfer_id"
  end

  create_table "decidim_authorization_transfers", force: :cascade do |t|
    t.bigint "authorization_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "source_user_id", null: false
    t.bigint "user_id", null: false
    t.index ["authorization_id"], name: "index_decidim_authorization_transfers_on_authorization_id"
    t.index ["source_user_id"], name: "index_decidim_authorization_transfers_on_source_user_id"
    t.index ["user_id"], name: "index_decidim_authorization_transfers_on_user_id"
  end

  create_table "decidim_authorizations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_user_id", null: false
    t.datetime "granted_at", precision: nil
    t.jsonb "metadata"
    t.string "name", null: false
    t.string "unique_id"
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "verification_metadata", default: {}
    t.index ["decidim_user_id", "name"], name: "index_decidim_authorizations_on_decidim_user_id_and_name", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_authorizations_on_decidim_user_id"
    t.index ["unique_id"], name: "index_decidim_authorizations_on_unique_id"
  end

  create_table "decidim_awesome_authorization_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_organization_id", null: false
    t.jsonb "name", default: {}, null: false
    t.jsonb "purpose", default: {}, null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_organization_id"], name: "decidim_awesome_authorization_groups_organization_id"
  end

  create_table "decidim_awesome_authorization_members", force: :cascade do |t|
    t.bigint "authorization_group_id", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "updated_at", null: false
    t.index ["authorization_group_id", "email"], name: "index_auth_members_group_email", unique: true
    t.index ["authorization_group_id"], name: "decidim_awesome_authorization_members_authorization_group_id"
  end

  create_table "decidim_awesome_config", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "value"
    t.string "var"
    t.index ["decidim_organization_id"], name: "index_decidim_awesome_on_decidim_organization_id"
    t.index ["var", "decidim_organization_id"], name: "index_decidim_awesome_organization_var", unique: true
  end

  create_table "decidim_awesome_config_constraints", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_awesome_config_id", null: false
    t.jsonb "settings"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_awesome_config_id"], name: "decidim_awesome_config_constraints_config"
    t.index ["settings", "decidim_awesome_config_id"], name: "index_decidim_awesome_settings_awesome_config", unique: true
  end

  create_table "decidim_awesome_editor_images", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id", null: false
    t.bigint "decidim_organization_id", null: false
    t.string "image"
    t.string "path"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_author_id"], name: "decidim_awesome_editor_images_author"
    t.index ["decidim_organization_id"], name: "decidim_awesome_editor_images_constraint_organization"
  end

  create_table "decidim_awesome_proposal_extra_fields", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_proposal_id", null: false
    t.string "decidim_proposal_type", null: false
    t.datetime "deleted_at"
    t.string "private_body"
    t.datetime "private_body_updated_at", precision: nil
    t.datetime "updated_at", null: false
    t.jsonb "vote_weight_totals"
    t.integer "weight_total", default: 0
    t.index ["decidim_proposal_id", "decidim_proposal_type"], name: "index_decidim_awesome_proposal_extra_fields_on_decidim_proposal"
    t.index ["deleted_at"], name: "index_decidim_awesome_proposal_extra_fields_on_deleted_at"
  end

  create_table "decidim_awesome_vote_weights", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "proposal_vote_id", null: false
    t.datetime "updated_at", null: false
    t.integer "weight", default: 1, null: false
    t.index ["proposal_vote_id"], name: "decidim_awesome_proposals_weights_vote"
  end

  create_table "decidim_blogs_posts", id: :serial, force: :cascade do |t|
    t.jsonb "body"
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.integer "decidim_component_id"
    t.datetime "deleted_at"
    t.integer "follows_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "published_at", precision: nil
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_blogs_posts_on_decidim_author"
    t.index ["decidim_component_id"], name: "index_decidim_blogs_posts_on_decidim_component_id"
    t.index ["deleted_at"], name: "index_decidim_blogs_posts_on_deleted_at"
  end

  create_table "decidim_budgets_budgets", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_component_id"
    t.bigint "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.jsonb "title"
    t.bigint "total_budget", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_component_id"], name: "index_decidim_budgets_budgets_on_decidim_component_id"
    t.index ["decidim_scope_id"], name: "index_decidim_budgets_budgets_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_budgets_budgets_on_deleted_at"
  end

  create_table "decidim_budgets_line_items", id: :serial, force: :cascade do |t|
    t.integer "decidim_order_id"
    t.integer "decidim_project_id"
    t.index ["decidim_order_id", "decidim_project_id"], name: "decidim_budgets_line_items_order_project_unique", unique: true
    t.index ["decidim_order_id"], name: "index_decidim_budgets_line_items_on_decidim_order_id"
    t.index ["decidim_project_id"], name: "index_decidim_budgets_line_items_on_decidim_project_id"
  end

  create_table "decidim_budgets_orders", id: :serial, force: :cascade do |t|
    t.datetime "checked_out_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_budgets_budget_id"
    t.integer "decidim_user_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_budgets_budget_id"], name: "index_decidim_budgets_orders_on_decidim_budgets_budget_id"
    t.index ["decidim_user_id"], name: "index_decidim_budgets_orders_on_decidim_user_id"
  end

  create_table "decidim_budgets_projects", id: :serial, force: :cascade do |t|
    t.text "address"
    t.bigint "budget_amount", null: false
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_budgets_budget_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.integer "follows_count", default: 0, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "reference"
    t.date "selected_at"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_budgets_budget_id"], name: "index_decidim_budgets_projects_on_decidim_budgets_budget_id"
    t.index ["decidim_scope_id"], name: "index_decidim_budgets_projects_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_budgets_projects_on_deleted_at"
  end

  create_table "decidim_categories", id: :serial, force: :cascade do |t|
    t.integer "decidim_participatory_space_id"
    t.string "decidim_participatory_space_type"
    t.jsonb "description"
    t.jsonb "name", null: false
    t.integer "parent_id"
    t.integer "weight", default: 0, null: false
    t.index ["decidim_participatory_space_id", "decidim_participatory_space_type"], name: "index_decidim_categories_on_decidim_participatory_space"
    t.index ["parent_id"], name: "index_decidim_categories_on_parent_id"
  end

  create_table "decidim_categorizations", force: :cascade do |t|
    t.bigint "categorizable_id", null: false
    t.string "categorizable_type"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_category_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["categorizable_type", "categorizable_id"], name: "decidim_categorizations_categorizable_id_and_type"
    t.index ["decidim_category_id"], name: "index_decidim_categorizations_on_decidim_category_id"
  end

  create_table "decidim_coauthorships", force: :cascade do |t|
    t.bigint "coauthorable_id"
    t.string "coauthorable_type"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["coauthorable_type", "coauthorable_id"], name: "index_coauthorable_on_coauthorship"
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_coauthorships_on_decidim_author"
  end

  create_table "decidim_collaborative_texts_documents", force: :cascade do |t|
    t.boolean "accepting_suggestions", default: false, null: false
    t.jsonb "announcement"
    t.integer "coauthorships_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "decidim_component_id"
    t.datetime "deleted_at"
    t.integer "document_versions_count", default: 0, null: false
    t.datetime "published_at", precision: nil
    t.integer "suggestions_count", default: 0, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["coauthorships_count"], name: "idx_decidim_collaborative_texts_documents_coauthorships_count"
    t.index ["deleted_at"], name: "index_decidim_collaborative_texts_documents_on_deleted_at"
    t.index ["document_versions_count"], name: "idx_decidim_collaborative_texts_documents_versions_count"
    t.index ["published_at"], name: "index_decidim_collaborative_texts_documents_on_published_at"
    t.index ["suggestions_count"], name: "idx_decidim_collaborative_texts_documents_suggestions_count"
  end

  create_table "decidim_collaborative_texts_suggestions", force: :cascade do |t|
    t.jsonb "changeset", default: {}, null: false
    t.datetime "created_at", null: false
    t.bigint "decidim_author_id"
    t.string "decidim_author_type"
    t.bigint "document_version_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_author_type", "decidim_author_id"], name: "index_collaborative_texts_suggestions_on_author"
    t.index ["document_version_id"], name: "index_collaborative_texts_suggestions_on_version_id"
  end

  create_table "decidim_collaborative_texts_versions", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.bigint "document_id", null: false
    t.boolean "draft", default: false, null: false
    t.integer "suggestions_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_decidim_collaborative_texts_versions_on_deleted_at"
    t.index ["document_id"], name: "index_decidim_collaborative_texts_versions_on_document_id"
    t.index ["suggestions_count"], name: "idx_decidim_collaborative_texts_versions_suggestions_count"
  end

  create_table "decidim_comments_comment_votes", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.integer "decidim_comment_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", null: false
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_comments_comment_votes_on_decidim_author"
    t.index ["decidim_author_id"], name: "decidim_comments_comment_vote_author"
    t.index ["decidim_comment_id", "decidim_author_id"], name: "decidim_comments_comment_vote_comment_author_unique", unique: true
    t.index ["decidim_comment_id"], name: "decidim_comments_comment_vote_comment"
  end

  create_table "decidim_comments_comments", id: :serial, force: :cascade do |t|
    t.integer "alignment", default: 0, null: false
    t.jsonb "body"
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.integer "decidim_commentable_id", null: false
    t.string "decidim_commentable_type", null: false
    t.integer "decidim_participatory_space_id"
    t.string "decidim_participatory_space_type"
    t.integer "decidim_root_commentable_id", null: false
    t.string "decidim_root_commentable_type", null: false
    t.datetime "deleted_at", precision: nil
    t.integer "depth", default: 0, null: false
    t.integer "down_votes_count", default: 0, null: false
    t.integer "up_votes_count", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "index_decidim_comments_comments_on_created_at"
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_comments_comments_on_decidim_author"
    t.index ["decidim_author_id"], name: "decidim_comments_comment_author"
    t.index ["decidim_commentable_type", "decidim_commentable_id"], name: "decidim_comments_comment_commentable"
    t.index ["decidim_participatory_space_id", "decidim_participatory_space_type"], name: "index_decidim_comments_on_decidim_participatory_space"
    t.index ["decidim_root_commentable_type", "decidim_root_commentable_id"], name: "decidim_comments_comment_root_commentable"
  end

  create_table "decidim_components", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "deleted_at"
    t.string "manifest_name"
    t.jsonb "name"
    t.integer "participatory_space_id", null: false
    t.string "participatory_space_type", null: false
    t.jsonb "permissions"
    t.datetime "published_at", precision: nil
    t.jsonb "settings", default: {}
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "visible", default: true
    t.integer "weight", default: 0
    t.index ["deleted_at"], name: "index_decidim_components_on_deleted_at"
    t.index ["participatory_space_id", "participatory_space_type"], name: "index_decidim_components_on_decidim_participatory_space"
  end

  create_table "decidim_conference_speaker_conference_meetings", force: :cascade do |t|
    t.bigint "conference_meeting_id", null: false
    t.bigint "conference_speaker_id", null: false
    t.index ["conference_meeting_id"], name: "index_meetings_on_decidim_conference_meeting_id"
    t.index ["conference_speaker_id"], name: "index_meetings_on_decidim_conference_speaker_id"
  end

  create_table "decidim_conference_speakers", force: :cascade do |t|
    t.jsonb "affiliation"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conference_id"
    t.bigint "decidim_user_id"
    t.string "full_name"
    t.string "personal_url"
    t.jsonb "position"
    t.datetime "published_at"
    t.jsonb "short_bio"
    t.string "twitter_handle"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conference_id"], name: "index_decidim_conference_speakers_on_decidim_conference_id"
    t.index ["decidim_user_id"], name: "index_decidim_conference_speaker_on_decidim_user_id"
  end

  create_table "decidim_conference_user_roles", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_conference_id"
    t.integer "decidim_user_id"
    t.string "role"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conference_id", "decidim_user_id", "role"], name: "index_unique_user_and_conference_role", unique: true
  end

  create_table "decidim_conferences", force: :cascade do |t|
    t.integer "available_slots", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description", null: false
    t.datetime "diploma_sent_at", precision: nil
    t.date "end_date"
    t.integer "follows_count", default: 0, null: false
    t.string "location"
    t.jsonb "objectives", null: false
    t.boolean "promoted", default: false
    t.datetime "published_at", precision: nil
    t.string "reference"
    t.jsonb "registration_terms"
    t.boolean "registrations_enabled", default: false, null: false
    t.boolean "scopes_enabled", default: true, null: false
    t.jsonb "short_description", null: false
    t.boolean "show_statistics", default: false
    t.date "sign_date"
    t.string "signature_name"
    t.jsonb "slogan", null: false
    t.string "slug", null: false
    t.date "start_date"
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_organization_id", "slug"], name: "index_unique_conference_slug_and_organization", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_conferences_on_decidim_organization_id"
    t.index ["decidim_scope_id"], name: "index_decidim_conferences_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_conferences_on_deleted_at"
  end

  create_table "decidim_conferences_conference_invites", force: :cascade do |t|
    t.datetime "accepted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conference_id", null: false
    t.integer "decidim_conference_registration_type_id"
    t.bigint "decidim_user_id", null: false
    t.datetime "rejected_at", precision: nil
    t.datetime "sent_at", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conference_id"], name: "idx_decidim_conferences_invites_on_conference_id"
    t.index ["decidim_conference_registration_type_id"], name: "ixd_conferences_on_registration_type_id"
    t.index ["decidim_user_id"], name: "index_decidim_conferences_conference_invites_on_decidim_user_id"
  end

  create_table "decidim_conferences_conference_meeting_registration_types", force: :cascade do |t|
    t.bigint "conference_meeting_id", null: false
    t.bigint "registration_type_id", null: false
    t.index ["conference_meeting_id"], name: "index_registrations_on_decidim_conference_meeting_id"
    t.index ["registration_type_id"], name: "index_meetings_on_decidim_registration_type_id"
  end

  create_table "decidim_conferences_conference_registrations", force: :cascade do |t|
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conference_id", null: false
    t.integer "decidim_conference_registration_type_id"
    t.bigint "decidim_user_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conference_id"], name: "index_conferences_registrations_on_decidim_conference"
    t.index ["decidim_conference_registration_type_id"], name: "idx_conferences_registrations_on_registration_type_id"
    t.index ["decidim_user_id", "decidim_conference_id"], name: "decidim_conferences_registrations_user_conference_unique", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_conferences_registrations_on_decidim_user_id"
  end

  create_table "decidim_conferences_media_links", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.date "date"
    t.bigint "decidim_conference_id"
    t.string "link", null: false
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_conference_id"], name: "index_decidim_conferences_media_links_on_decidim_conference_id"
  end

  create_table "decidim_conferences_partners", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conference_id"
    t.string "link"
    t.string "name", null: false
    t.string "partner_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_conference_id"], name: "index_decidim_conferences_partners_on_decidim_conference_id"
    t.index ["weight", "partner_type"], name: "index_decidim_conferences_partners_on_weight_and_partner_type"
  end

  create_table "decidim_conferences_registration_types", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conference_id"
    t.jsonb "description", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.datetime "published_at", precision: nil
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 0, null: false
    t.index ["decidim_conference_id"], name: "idx_registration_types_on_decidim_conference_id"
    t.index ["published_at"], name: "index_decidim_conferences_registration_types_on_published_at"
  end

  create_table "decidim_content_block_attachments", force: :cascade do |t|
    t.bigint "decidim_content_block_id", null: false
    t.string "name"
    t.index ["decidim_content_block_id"], name: "decidim_content_block_attachments_on_content_block"
  end

  create_table "decidim_content_blocks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "decidim_organization_id", null: false
    t.jsonb "images", default: {}
    t.string "manifest_name", null: false
    t.datetime "published_at", precision: nil
    t.string "scope_name", null: false
    t.integer "scoped_resource_id"
    t.jsonb "settings"
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["decidim_organization_id", "scope_name", "scoped_resource_id", "manifest_name"], name: "idx_decidim_content_blocks_org_id_scope_scope_id_manifest"
    t.index ["decidim_organization_id"], name: "index_decidim_content_blocks_on_decidim_organization_id"
    t.index ["manifest_name"], name: "index_decidim_content_blocks_on_manifest_name"
    t.index ["published_at"], name: "index_decidim_content_blocks_on_published_at"
    t.index ["scope_name"], name: "index_decidim_content_blocks_on_scope_name"
  end

  create_table "decidim_contextual_help_sections", force: :cascade do |t|
    t.jsonb "content", null: false
    t.bigint "organization_id", null: false
    t.string "section_id", null: false
    t.index ["organization_id"], name: "index_decidim_contextual_help_sections_on_organization_id"
    t.index ["section_id"], name: "index_decidim_contextual_help_sections_on_section_id"
  end

  create_table "decidim_debates_debates", id: :serial, force: :cascade do |t|
    t.datetime "closed_at", precision: nil
    t.integer "comments_count", default: 0, null: false
    t.boolean "comments_enabled", default: true
    t.string "comments_layout"
    t.jsonb "conclusions"
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.integer "decidim_component_id"
    t.bigint "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.datetime "end_time", precision: nil
    t.jsonb "extra"
    t.integer "follows_count", default: 0, null: false
    t.jsonb "information_updates"
    t.jsonb "instructions"
    t.datetime "last_comment_at", precision: nil
    t.integer "last_comment_by_id"
    t.string "last_comment_by_type"
    t.integer "likes_count", default: 0, null: false
    t.string "reference"
    t.datetime "start_time", precision: nil
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["closed_at"], name: "index_decidim_debates_debates_on_closed_at"
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_debates_debates_on_decidim_author"
    t.index ["decidim_component_id"], name: "index_decidim_debates_debates_on_decidim_component_id"
    t.index ["decidim_scope_id"], name: "index_decidim_debates_debates_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_debates_debates_on_deleted_at"
    t.index ["likes_count"], name: "index_decidim_debates_debates_on_likes_count"
  end

  create_table "decidim_editor_images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_author_id", null: false
    t.bigint "decidim_organization_id", null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_author_id"], name: "decidim_editor_images_author"
    t.index ["decidim_organization_id"], name: "decidim_editor_images_constraint_organization"
  end

  create_table "decidim_elections_elections", force: :cascade do |t|
    t.boolean "allow_census_check_before_start", default: false, null: false
    t.jsonb "announcement"
    t.string "census_manifest"
    t.jsonb "census_settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.integer "decidim_component_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.datetime "end_at", precision: nil
    t.datetime "published_at", precision: nil
    t.datetime "published_results_at"
    t.string "results_availability", default: "after_end", null: false
    t.datetime "start_at", precision: nil
    t.jsonb "title"
    t.datetime "updated_at", null: false
    t.integer "votes_count", default: 0, null: false
    t.index ["census_manifest"], name: "index_decidim_elections_elections_on_census_manifest"
    t.index ["deleted_at"], name: "index_decidim_elections_elections_on_deleted_at"
    t.index ["end_at"], name: "index_decidim_elections_elections_on_end_at"
    t.index ["published_at"], name: "index_decidim_elections_elections_on_published_at"
    t.index ["start_at"], name: "index_decidim_elections_elections_on_start_at"
  end

  create_table "decidim_elections_questions", force: :cascade do |t|
    t.jsonb "body", default: {}, null: false
    t.datetime "created_at", null: false
    t.jsonb "description", default: {}
    t.bigint "election_id", null: false
    t.boolean "mandatory", default: false, null: false
    t.integer "max_choices"
    t.integer "position"
    t.datetime "published_results_at"
    t.string "question_type", default: "multiple_option", null: false
    t.integer "response_options_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "votes_count", default: 0, null: false
    t.datetime "voting_enabled_at"
    t.index ["election_id"], name: "index_questions_on_election_id"
  end

  create_table "decidim_elections_response_options", force: :cascade do |t|
    t.jsonb "body", default: {}, null: false
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.datetime "updated_at", null: false
    t.integer "votes_count", default: 0, null: false
    t.index ["question_id"], name: "index_response_options_on_question_id"
  end

  create_table "decidim_elections_voters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", null: false
    t.bigint "election_id", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_decidim_elections_voters_on_election_id"
  end

  create_table "decidim_elections_votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.bigint "response_option_id", null: false
    t.datetime "updated_at", null: false
    t.string "voter_uid", null: false
    t.index ["question_id", "voter_uid", "response_option_id"], name: "index_elections_votes_on__voter_uid_and_response", unique: true
    t.index ["question_id"], name: "index_decidim_elections_votes_on_question_id"
    t.index ["response_option_id"], name: "index_decidim_elections_votes_on_response_option_id"
    t.index ["voter_uid"], name: "index_decidim_elections_votes_on_voter_uid"
  end

  create_table "decidim_follows", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_followable_id"
    t.string "decidim_followable_type"
    t.bigint "decidim_user_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_followable_id", "decidim_followable_type"], name: "index_follows_followable_id_and_type"
    t.index ["decidim_user_id", "decidim_followable_id", "decidim_followable_type"], name: "index_uniq_on_follows_user_and_followable", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_follows_on_decidim_user_id"
  end

  create_table "decidim_forms_display_conditions", force: :cascade do |t|
    t.integer "condition_type", default: 0, null: false
    t.jsonb "condition_value"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_condition_question_id", null: false
    t.bigint "decidim_question_id", null: false
    t.bigint "decidim_response_option_id"
    t.boolean "mandatory", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_condition_question_id"], name: "decidim_forms_display_condition_condition_question"
    t.index ["decidim_question_id"], name: "decidim_forms_display_condition_question"
    t.index ["decidim_response_option_id"], name: "decidim_forms_display_condition_response_option"
  end

  create_table "decidim_forms_question_matrix_rows", force: :cascade do |t|
    t.jsonb "body"
    t.bigint "decidim_question_id"
    t.integer "position"
    t.index ["decidim_question_id"], name: "index_decidim_forms_question_matrix_questionnaire_id"
    t.index ["position"], name: "index_decidim_forms_question_matrix_rows_on_position"
  end

  create_table "decidim_forms_questionnaires", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "description"
    t.datetime "published_at", precision: nil
    t.integer "questionnaire_for_id"
    t.string "questionnaire_for_type"
    t.string "salt"
    t.jsonb "title"
    t.jsonb "tos"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["questionnaire_for_type", "questionnaire_for_id"], name: "index_decidim_forms_questionnaires_questionnaire_for"
  end

  create_table "decidim_forms_questions", id: :serial, force: :cascade do |t|
    t.jsonb "body"
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_questionnaire_id"
    t.jsonb "description"
    t.integer "display_conditions_count", default: 0, null: false
    t.integer "display_conditions_for_other_questions_count", default: 0, null: false
    t.boolean "mandatory"
    t.integer "matrix_rows_count", default: 0, null: false
    t.integer "max_characters", default: 0
    t.integer "max_choices"
    t.integer "position"
    t.string "question_type"
    t.integer "response_options_count", default: 0, null: false
    t.datetime "survey_responses_published_at"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_questionnaire_id"], name: "index_decidim_forms_questions_on_decidim_questionnaire_id"
    t.index ["position"], name: "index_decidim_forms_questions_on_position"
  end

  create_table "decidim_forms_response_choices", force: :cascade do |t|
    t.jsonb "body"
    t.text "custom_body"
    t.integer "decidim_question_matrix_row_id"
    t.bigint "decidim_response_id"
    t.bigint "decidim_response_option_id"
    t.integer "position"
    t.index ["decidim_response_id"], name: "index_decidim_forms_response_choices_response_id"
    t.index ["decidim_response_option_id"], name: "index_decidim_forms_response_choices_response_option_id"
  end

  create_table "decidim_forms_response_options", force: :cascade do |t|
    t.jsonb "body"
    t.bigint "decidim_question_id"
    t.boolean "free_text"
    t.index ["decidim_question_id"], name: "index_decidim_forms_response_options_question_id"
  end

  create_table "decidim_forms_responses", id: :serial, force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_question_id"
    t.integer "decidim_questionnaire_id"
    t.integer "decidim_user_id"
    t.string "ip_hash"
    t.string "session_token", default: "", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_question_id"], name: "index_decidim_forms_responses_question_id"
    t.index ["decidim_questionnaire_id"], name: "index_decidim_forms_responses_on_decidim_questionnaire_id"
    t.index ["decidim_user_id"], name: "index_decidim_forms_responses_on_decidim_user_id"
    t.index ["ip_hash"], name: "index_decidim_forms_responses_on_ip_hash"
    t.index ["session_token"], name: "index_decidim_forms_responses_on_session_token"
  end

  create_table "decidim_gamification_badge_scores", force: :cascade do |t|
    t.string "badge_name", null: false
    t.bigint "user_id", null: false
    t.integer "value", default: 0, null: false
    t.index ["user_id"], name: "index_decidim_gamification_badge_scores_on_user_id"
  end

  create_table "decidim_identities", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.integer "decidim_user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_decidim_identities_on_decidim_organization_id"
    t.index ["decidim_user_id"], name: "index_decidim_identities_on_decidim_user_id"
    t.index ["provider", "uid", "decidim_organization_id"], name: "decidim_identities_provider_uid_organization_unique", unique: true
  end

  create_table "decidim_impersonation_logs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_admin_id"
    t.bigint "decidim_user_id"
    t.datetime "ended_at", precision: nil
    t.datetime "expired_at", precision: nil
    t.text "reason"
    t.datetime "started_at", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_admin_id"], name: "index_decidim_impersonation_logs_on_decidim_admin_id"
    t.index ["decidim_user_id"], name: "index_decidim_impersonation_logs_on_decidim_user_id"
  end

  create_table "decidim_initiatives", force: :cascade do |t|
    t.jsonb "answer"
    t.string "answer_url"
    t.datetime "answered_at", precision: nil
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_area_id"
    t.bigint "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.integer "decidim_organization_id"
    t.jsonb "definition"
    t.jsonb "description", null: false
    t.datetime "first_progress_notification_at", precision: nil
    t.integer "follows_count", default: 0, null: false
    t.boolean "has_custom_fields", default: false, null: false
    t.jsonb "offline_votes", default: {}
    t.jsonb "online_votes", default: {}
    t.datetime "published_at", precision: nil
    t.jsonb "question"
    t.jsonb "reasons"
    t.string "reference"
    t.integer "scoped_type_id"
    t.datetime "second_progress_notification_at", precision: nil
    t.date "signature_end_date"
    t.date "signature_start_date"
    t.integer "signature_type", default: 0, null: false
    t.integer "state", default: 0, null: false
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index "md5((description)::text)", name: "decidim_initiatives_description_search"
    t.index ["answered_at"], name: "index_decidim_initiatives_on_answered_at"
    t.index ["decidim_area_id"], name: "index_decidim_initiatives_on_decidim_area_id"
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_initiatives_on_decidim_author"
    t.index ["decidim_organization_id"], name: "index_decidim_initiatives_on_decidim_organization_id"
    t.index ["published_at"], name: "index_decidim_initiatives_on_published_at"
    t.index ["scoped_type_id"], name: "index_decidim_initiatives_on_scoped_type_id"
    t.index ["title"], name: "decidim_initiatives_title_search"
  end

  create_table "decidim_initiatives_committee_members", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_initiatives_id"
    t.bigint "decidim_users_id"
    t.integer "state", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_initiatives_id"], name: "index_decidim_committee_members_initiative"
    t.index ["decidim_users_id"], name: "index_decidim_committee_members_user"
    t.index ["state"], name: "index_decidim_initiatives_committee_members_on_state"
  end

  create_table "decidim_initiatives_settings", force: :cascade do |t|
    t.bigint "decidim_organization_id"
    t.string "initiatives_order", default: "random"
    t.index ["decidim_organization_id"], name: "index_decidim_initiatives_settings_on_decidim_organization_id"
  end

  create_table "decidim_initiatives_type_scopes", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_initiatives_types_id"
    t.bigint "decidim_scopes_id"
    t.bigint "decidim_taxonomy_id"
    t.integer "supports_required", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_initiatives_types_id"], name: "idx_scoped_initiative_type_type"
    t.index ["decidim_scopes_id"], name: "idx_scoped_initiative_type_scope"
    t.index ["decidim_taxonomy_id"], name: "index_decidim_initiatives_type_scopes_on_decidim_taxonomy_id"
  end

  create_table "decidim_initiatives_types", force: :cascade do |t|
    t.boolean "area_enabled", default: false, null: false
    t.boolean "attachments_enabled", default: false, null: false
    t.boolean "child_scope_threshold_enabled", default: false, null: false
    t.boolean "collect_user_extra_fields", default: false
    t.boolean "comments_enabled", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "custom_signature_end_date_enabled", default: false, null: false
    t.integer "decidim_organization_id"
    t.jsonb "description", null: false
    t.string "document_number_authorization_handler"
    t.jsonb "extra_fields_legal_information"
    t.integer "minimum_committee_members"
    t.boolean "only_global_scope_enabled", default: false, null: false
    t.boolean "promoting_committee_enabled", default: true, null: false
    t.integer "signature_type", default: 0, null: false
    t.jsonb "title", null: false
    t.boolean "undo_online_signatures_enabled", default: true, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "validate_sms_code_on_votes", default: false
    t.index ["decidim_organization_id"], name: "index_decidim_initiative_types_on_decidim_organization_id"
  end

  create_table "decidim_initiatives_votes", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id", null: false
    t.bigint "decidim_initiative_id", null: false
    t.integer "decidim_scope_id"
    t.text "encrypted_metadata"
    t.string "hash_id"
    t.string "timestamp"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_author_id"], name: "index_decidim_initiatives_votes_on_decidim_author_id"
    t.index ["decidim_initiative_id"], name: "index_decidim_initiatives_votes_on_decidim_initiative_id"
    t.index ["hash_id"], name: "index_decidim_initiatives_votes_on_hash_id"
  end

  create_table "decidim_internal_evaluation_internal_evaluations", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.bigint "decidim_author_id", null: false
    t.bigint "decidim_proposal_id", null: false
    t.bigint "decidim_proposal_state_id"
    t.datetime "updated_at", null: false
    t.index ["decidim_author_id"], name: "index_decidim_internal_evaluations_on_author"
    t.index ["decidim_proposal_id"], name: "index_decidim_internal_evaluations_on_proposal"
    t.index ["decidim_proposal_state_id"], name: "index_decidim_internal_evaluations_on_proposal_state"
  end

  create_table "decidim_kids_impersonation_minor_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_minor_id"
    t.bigint "decidim_tutor_id"
    t.datetime "ended_at", precision: nil
    t.datetime "expired_at", precision: nil
    t.datetime "started_at", precision: nil
    t.datetime "updated_at", null: false
    t.index ["decidim_minor_id"], name: "index_decidim_kids_impersonation_minor_logs_on_decidim_minor_id"
    t.index ["decidim_tutor_id"], name: "index_decidim_kids_impersonation_minor_logs_on_decidim_tutor_id"
  end

  create_table "decidim_kids_minor_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_minor_id", null: false
    t.bigint "decidim_tutor_id", null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_minor_id"], name: "index_decidim_kids_minor_accounts_on_decidim_minor_id"
    t.index ["decidim_tutor_id", "decidim_minor_id"], name: "decidim_kids_minor_accounts_unique_tutor_and_minor_ids", unique: true
    t.index ["decidim_tutor_id"], name: "index_decidim_kids_minor_accounts_on_decidim_tutor_id"
  end

  create_table "decidim_kids_minor_data", force: :cascade do |t|
    t.string "birthday"
    t.datetime "created_at", null: false
    t.bigint "decidim_user_id", null: false
    t.string "email"
    t.jsonb "extra_data", default: {}, null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["decidim_user_id"], name: "index_decidim_kids_minor_data_on_decidim_user_id"
  end

  create_table "decidim_kids_organization_configs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id", null: false
    t.boolean "enable_minors_participation", default: false, null: false
    t.integer "maximum_minor_accounts", default: 3, null: false
    t.integer "maximum_minor_age", default: 13, null: false
    t.integer "minimum_minor_age", default: 10, null: false
    t.string "minors_authorization"
    t.string "tutors_authorization"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_decidim_kids_organization"
  end

  create_table "decidim_kids_participatory_spaces_minors_configs", force: :cascade do |t|
    t.string "access_type", default: "all", null: false
    t.string "authorization"
    t.datetime "created_at", null: false
    t.integer "max_age", default: 16, null: false
    t.bigint "participatory_space_id"
    t.string "participatory_space_type"
    t.datetime "updated_at", null: false
    t.index ["participatory_space_type", "participatory_space_id"], name: "index_minor_config_on_space_type_and_id"
  end

  create_table "decidim_likes", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id"
    t.string "decidim_author_type"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_author_type", "decidim_author_id"], name: "idx_likes_authors"
    t.index ["resource_type", "resource_id"], name: "index_decidim_likes_on_resource_type_and_resource_id"
  end

  create_table "decidim_meetings_agenda_items", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_agenda_id"
    t.jsonb "description"
    t.integer "duration"
    t.bigint "parent_id"
    t.integer "position"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_agenda_id"], name: "index_decidim_meetings_agenda_items_on_decidim_agenda_id"
    t.index ["parent_id"], name: "index_decidim_meetings_agenda_items_on_parent_id"
  end

  create_table "decidim_meetings_agendas", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_meeting_id", null: false
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "visible"
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_agendas_on_decidim_meeting_id"
  end

  create_table "decidim_meetings_invites", force: :cascade do |t|
    t.datetime "accepted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_meeting_id", null: false
    t.bigint "decidim_user_id", null: false
    t.datetime "rejected_at", precision: nil
    t.datetime "sent_at", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_invites_on_decidim_meeting_id"
    t.index ["decidim_user_id"], name: "index_decidim_meetings_invites_on_decidim_user_id"
  end

  create_table "decidim_meetings_meeting_links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_component_id", null: false
    t.bigint "decidim_meeting_id", null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_component_id"], name: "index_decidim_meetings_meeting_links_on_decidim_component_id"
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_meeting_links_on_decidim_meeting_id"
  end

  create_table "decidim_meetings_meetings", id: :serial, force: :cascade do |t|
    t.text "address"
    t.integer "attendees_count"
    t.text "attending_organizations"
    t.string "audio_url"
    t.integer "available_slots", default: 0, null: false
    t.time "closed_at"
    t.jsonb "closing_report"
    t.boolean "closing_visible"
    t.integer "comments_count", default: 0, null: false
    t.boolean "comments_enabled", default: true
    t.datetime "comments_end_time", precision: nil
    t.datetime "comments_start_time", precision: nil
    t.integer "contributions_count"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "customize_registration_email", default: false
    t.integer "decidim_author_id"
    t.string "decidim_author_type"
    t.integer "decidim_component_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.jsonb "description"
    t.datetime "end_time", precision: nil
    t.jsonb "extra"
    t.integer "follows_count", default: 0, null: false
    t.integer "iframe_access_level", default: 0
    t.integer "iframe_embed_type", default: 0
    t.float "latitude"
    t.jsonb "location"
    t.jsonb "location_hints"
    t.float "longitude"
    t.string "online_meeting_url"
    t.boolean "private_meeting", default: false
    t.datetime "published_at", precision: nil
    t.string "reference"
    t.jsonb "registration_email_custom_content"
    t.boolean "registration_form_enabled", default: false
    t.jsonb "registration_terms"
    t.integer "registration_type", default: 0, null: false
    t.string "registration_url"
    t.boolean "registrations_enabled", default: false, null: false
    t.boolean "reminder_enabled", default: true, null: false
    t.jsonb "reminder_message_custom_content", default: {}, null: false
    t.integer "reserved_slots", default: 0, null: false
    t.string "salt"
    t.integer "send_reminders_before_hours"
    t.datetime "start_time", precision: nil
    t.string "state"
    t.jsonb "title"
    t.boolean "transparent", default: true
    t.integer "type_of_meeting", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "video_url"
    t.datetime "withdrawn_at", precision: nil
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_meetings_meetings_on_author"
    t.index ["decidim_author_id"], name: "index_decidim_meetings_meetings_on_decidim_author_id"
    t.index ["decidim_component_id"], name: "index_decidim_meetings_meetings_on_decidim_component_id"
    t.index ["decidim_scope_id"], name: "index_decidim_meetings_meetings_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_meetings_meetings_on_deleted_at"
  end

  create_table "decidim_meetings_polls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_meeting_id"
    t.datetime "updated_at", null: false
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_polls_on_decidim_meeting_id"
  end

  create_table "decidim_meetings_questionnaires", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "questionnaire_for_id"
    t.string "questionnaire_for_type"
    t.datetime "updated_at", null: false
    t.index ["questionnaire_for_type", "questionnaire_for_id"], name: "index_decidim_meetings_questionnaires_questionnaire_for"
  end

  create_table "decidim_meetings_questions", force: :cascade do |t|
    t.jsonb "body"
    t.datetime "created_at", null: false
    t.bigint "decidim_questionnaire_id"
    t.integer "max_choices"
    t.integer "position"
    t.string "question_type"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
    t.index ["decidim_questionnaire_id"], name: "index_decidim_meetings_questions_on_decidim_questionnaire_id"
    t.index ["position"], name: "index_decidim_meetings_questions_on_position"
  end

  create_table "decidim_meetings_registrations", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_meeting_id", null: false
    t.bigint "decidim_user_id", null: false
    t.boolean "public_participation", default: false
    t.string "status", default: "registered"
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "validated_at", precision: nil
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_registrations_on_decidim_meeting_id"
    t.index ["decidim_user_id", "decidim_meeting_id"], name: "decidim_meetings_registrations_user_meeting_unique", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_meetings_registrations_on_decidim_user_id"
    t.index ["status"], name: "index_decidim_meetings_registrations_on_status"
  end

  create_table "decidim_meetings_response_choices", force: :cascade do |t|
    t.jsonb "body"
    t.text "custom_body"
    t.bigint "decidim_response_id"
    t.bigint "decidim_response_option_id"
    t.integer "position"
    t.index ["decidim_response_id"], name: "index_decidim_meetings_response_choices_response_id"
    t.index ["decidim_response_option_id"], name: "index_decidim_meetings_response_choices_response_option_id"
  end

  create_table "decidim_meetings_response_options", force: :cascade do |t|
    t.jsonb "body"
    t.bigint "decidim_question_id"
    t.index ["decidim_question_id"], name: "index_decidim_meetings_response_options_question_id"
  end

  create_table "decidim_meetings_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_question_id"
    t.bigint "decidim_questionnaire_id"
    t.bigint "decidim_user_id"
    t.datetime "updated_at", null: false
    t.index ["decidim_question_id"], name: "index_decidim_meetings_responses_question_id"
    t.index ["decidim_questionnaire_id"], name: "index_decidim_meetings_responses_on_decidim_questionnaire_id"
    t.index ["decidim_user_id"], name: "index_decidim_meetings_responses_on_decidim_user_id"
  end

  create_table "decidim_meetings_services", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_meeting_id", null: false
    t.jsonb "description"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_meeting_id"], name: "index_decidim_meetings_services_on_decidim_meeting_id"
  end

  create_table "decidim_members", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_user_id"
    t.integer "participatory_space_id"
    t.string "participatory_space_type"
    t.boolean "published", default: false
    t.jsonb "role"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_user_id", "participatory_space_type", "participatory_space_id"], name: "unique_space_members", unique: true
    t.index ["decidim_user_id"], name: "index_decidim_members_on_user_id"
    t.index ["participatory_space_type", "participatory_space_id"], name: "index_decidim_members_on_participatory_space"
  end

  create_table "decidim_messaging_conversations", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "decidim_messaging_messages", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conversation_id", null: false
    t.bigint "decidim_sender_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conversation_id"], name: "index_decidim_messaging_messages_on_decidim_conversation_id"
    t.index ["decidim_sender_id"], name: "index_decidim_messaging_messages_on_decidim_sender_id"
  end

  create_table "decidim_messaging_participations", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_conversation_id", null: false
    t.bigint "decidim_participant_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_conversation_id"], name: "index_conversation_participations_on_conversation_id"
    t.index ["decidim_participant_id"], name: "index_conversation_participations_on_participant_id"
  end

  create_table "decidim_messaging_receipts", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_message_id", null: false
    t.bigint "decidim_recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_message_id"], name: "index_decidim_messaging_receipts_on_decidim_message_id"
    t.index ["decidim_recipient_id"], name: "index_decidim_messaging_receipts_on_decidim_recipient_id"
  end

  create_table "decidim_metrics", force: :cascade do |t|
    t.integer "cumulative", null: false
    t.date "day", null: false
    t.bigint "decidim_category_id"
    t.bigint "decidim_organization_id", null: false
    t.bigint "decidim_taxonomy_id"
    t.string "metric_type", null: false
    t.bigint "participatory_space_id"
    t.string "participatory_space_type"
    t.integer "quantity", null: false
    t.bigint "related_object_id"
    t.string "related_object_type"
    t.index ["day", "metric_type", "decidim_organization_id", "participatory_space_type", "participatory_space_id", "related_object_type", "related_object_id", "decidim_category_id"], name: "idx_metric_by_day_type_org_space_object_category", unique: true
    t.index ["day"], name: "index_decidim_metrics_on_day"
    t.index ["decidim_category_id"], name: "index_decidim_metrics_on_decidim_category_id"
    t.index ["decidim_organization_id"], name: "index_decidim_metrics_on_decidim_organization_id"
    t.index ["decidim_taxonomy_id"], name: "index_decidim_metrics_on_decidim_taxonomy_id"
    t.index ["metric_type"], name: "index_decidim_metrics_on_metric_type"
    t.index ["participatory_space_type", "participatory_space_id"], name: "index_metric_on_participatory_space_id_and_type"
    t.index ["related_object_type", "related_object_id"], name: "index_metric_on_related_object_id_and_type"
  end

  create_table "decidim_moderations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_participatory_space_id", null: false
    t.string "decidim_participatory_space_type", null: false
    t.integer "decidim_reportable_id", null: false
    t.string "decidim_reportable_type", null: false
    t.datetime "hidden_at", precision: nil
    t.integer "report_count", default: 0, null: false
    t.text "reported_content"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_participatory_space_id", "decidim_participatory_space_type"], name: "decidim_moderations_participatory_space"
    t.index ["decidim_reportable_type", "decidim_reportable_id"], name: "decidim_moderations_reportable", unique: true
    t.index ["hidden_at"], name: "decidim_moderations_hidden_at"
    t.index ["report_count"], name: "decidim_moderations_report_count"
  end

  create_table "decidim_navigation_maps_blueprint_areas", force: :cascade do |t|
    t.jsonb "area"
    t.string "area_id"
    t.string "area_type"
    t.string "color"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_navigation_maps_blueprint_id", null: false
    t.jsonb "description", default: {}
    t.string "link"
    t.string "link_type"
    t.jsonb "title", default: {}
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_navigation_maps_blueprint_id"], name: "decidim_navigation_maps_constraint_blueprint_id"
  end

  create_table "decidim_navigation_maps_blueprints", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_content_block_id"
    t.bigint "decidim_organization_id", null: false
    t.jsonb "description", default: {}
    t.integer "height", default: 475, null: false
    t.string "image"
    t.jsonb "title", default: {}
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_content_block_id"], name: "decidim_navigation_maps_constraint_content_block"
    t.index ["decidim_organization_id"], name: "decidim_navigation_maps_constraint_organization"
  end

  create_table "decidim_newsletters", id: :serial, force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "extended_data", default: {}
    t.integer "organization_id"
    t.datetime "sent_at", precision: nil
    t.jsonb "subject"
    t.integer "total_deliveries"
    t.integer "total_recipients"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_id"], name: "index_decidim_newsletters_on_author_id"
    t.index ["organization_id"], name: "index_decidim_newsletters_on_organization_id"
  end

  create_table "decidim_notifications", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_resource_id", null: false
    t.string "decidim_resource_type", null: false
    t.bigint "decidim_user_id", null: false
    t.string "event_class", null: false
    t.string "event_name", null: false
    t.jsonb "extra"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_resource_id"], name: "index_decidim_notifications_on_decidim_resource_id"
    t.index ["decidim_user_id"], name: "index_decidim_notifications_on_decidim_user_id"
  end

  create_table "decidim_organizations", id: :serial, force: :cascade do |t|
    t.jsonb "admin_terms_of_service_body"
    t.string "available_authorizations", default: [], array: true
    t.string "available_locales", default: [], array: true
    t.boolean "badges_enabled", default: false, null: false
    t.jsonb "colors", default: {}
    t.integer "comments_max_length", default: 1000
    t.jsonb "content_security_policy", default: {}
    t.datetime "created_at", precision: nil, null: false
    t.string "default_locale", null: false
    t.jsonb "description"
    t.boolean "enable_machine_translations", default: false
    t.boolean "enable_omnipresent_banner", default: false, null: false
    t.string "external_domain_allowlist", default: [], array: true
    t.string "facebook_handler"
    t.jsonb "file_upload_settings"
    t.boolean "force_users_to_authenticate_before_access_organization", default: false
    t.string "github_handler"
    t.text "header_snippets"
    t.string "host", null: false
    t.jsonb "id_documents_explanation_text", default: {}
    t.string "id_documents_methods", default: ["online"], array: true
    t.string "instagram_handler"
    t.string "machine_translation_display_priority", default: "original", null: false
    t.jsonb "name", default: {}, null: false
    t.string "official_url"
    t.jsonb "omniauth_settings"
    t.jsonb "omnipresent_banner_short_description"
    t.jsonb "omnipresent_banner_title"
    t.string "omnipresent_banner_url"
    t.string "reference_prefix", null: false
    t.boolean "rich_text_editor_in_public_views", default: false
    t.string "secondary_hosts", default: [], array: true
    t.boolean "send_welcome_notification", default: false, null: false
    t.jsonb "short_name", default: {}, null: false
    t.jsonb "smtp_settings"
    t.string "time_zone", limit: 255, default: "UTC"
    t.datetime "tos_version", precision: nil
    t.string "twitter_handler"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "users_registration_mode", default: 0, null: false
    t.jsonb "welcome_notification_body"
    t.jsonb "welcome_notification_subject"
    t.string "youtube_handler"
    t.index ["host"], name: "index_decidim_organizations_on_host", unique: true
  end

  create_table "decidim_pages_pages", id: :serial, force: :cascade do |t|
    t.jsonb "body"
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_component_id"
    t.datetime "deleted_at"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_component_id"], name: "index_decidim_pages_pages_on_decidim_component_id"
    t.index ["deleted_at"], name: "index_decidim_pages_pages_on_deleted_at"
  end

  create_table "decidim_participatory_process_groups", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.jsonb "description", null: false
    t.jsonb "developer_group"
    t.string "group_url"
    t.jsonb "local_area"
    t.jsonb "meta_scope"
    t.jsonb "participatory_scope"
    t.jsonb "participatory_structure"
    t.boolean "promoted", default: false
    t.jsonb "target"
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "decidim_participatory_process_group_organization"
  end

  create_table "decidim_participatory_process_steps", id: :serial, force: :cascade do |t|
    t.boolean "active", default: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_participatory_process_id"
    t.jsonb "description"
    t.datetime "end_date", precision: nil
    t.jsonb "extra"
    t.integer "position"
    t.datetime "start_date", precision: nil
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_participatory_process_id", "active"], name: "unique_index_to_avoid_duplicate_active_steps", unique: true, where: "(active = true)"
    t.index ["decidim_participatory_process_id", "position"], name: "index_unique_position_for_process", unique: true
    t.index ["decidim_participatory_process_id"], name: "index_decidim_processes_steps__on_decidim_process_id"
    t.index ["position"], name: "index_order_by_position_for_steps"
  end

  create_table "decidim_participatory_process_user_roles", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_participatory_process_id"
    t.integer "decidim_user_id"
    t.string "role"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_participatory_process_id", "decidim_user_id", "role"], name: "index_unique_user_and_process_role", unique: true
    t.index ["decidim_user_id"], name: "idx_proces_user_role_on_user_id"
  end

  create_table "decidim_participatory_processes", id: :serial, force: :cascade do |t|
    t.integer "access_mode", default: 0, null: false
    t.jsonb "announcement"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_area_id"
    t.integer "decidim_organization_id"
    t.integer "decidim_participatory_process_group_id"
    t.integer "decidim_scope_id"
    t.bigint "decidim_scope_type_id"
    t.datetime "deleted_at"
    t.jsonb "description", null: false
    t.jsonb "developer_group"
    t.date "end_date"
    t.jsonb "extra"
    t.integer "follows_count", default: 0, null: false
    t.boolean "has_members", default: false
    t.jsonb "local_area"
    t.jsonb "meta_scope"
    t.jsonb "participatory_scope"
    t.jsonb "participatory_structure"
    t.boolean "private_space", default: false
    t.boolean "promoted", default: false
    t.datetime "published_at", precision: nil
    t.string "reference"
    t.boolean "scopes_enabled", default: true, null: false
    t.jsonb "short_description", null: false
    t.string "slug", null: false
    t.date "start_date"
    t.jsonb "subtitle", null: false
    t.jsonb "target"
    t.jsonb "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight", default: 1, null: false
    t.index ["decidim_area_id"], name: "index_decidim_participatory_processes_on_decidim_area_id"
    t.index ["decidim_organization_id", "slug"], name: "index_unique_process_slug_and_organization", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_processes_on_decidim_organization_id"
    t.index ["decidim_participatory_process_group_id"], name: "idx_process_on_process_group_id"
    t.index ["decidim_scope_id"], name: "idx_process_on_scope_id"
    t.index ["decidim_scope_type_id"], name: "index_decidim_participatory_processes_on_decidim_scope_type_id"
    t.index ["deleted_at"], name: "index_decidim_participatory_processes_on_deleted_at"
  end

  create_table "decidim_participatory_space_links", id: :serial, force: :cascade do |t|
    t.jsonb "data"
    t.integer "from_id", null: false
    t.string "from_type", null: false
    t.string "name", null: false
    t.integer "to_id", null: false
    t.string "to_type", null: false
    t.index ["from_type", "from_id"], name: "index_participatory_space_links_on_from"
    t.index ["name"], name: "index_participatory_space_links_name"
    t.index ["to_type", "to_id"], name: "index_participatory_space_links_on_to"
  end

  create_table "decidim_private_exports", force: :cascade do |t|
    t.integer "attached_to_id"
    t.string "attached_to_type"
    t.string "content_type", null: false
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "export_type", null: false
    t.string "file_size", null: false
    t.jsonb "metadata", default: {}
    t.datetime "updated_at", null: false
    t.uuid "uuid", null: false
    t.index ["uuid"], name: "index_decidim_private_exports_on_uuid", unique: true
  end

  create_table "decidim_proposals_evaluation_assignments", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_proposal_id", null: false
    t.bigint "evaluator_role_id", null: false
    t.string "evaluator_role_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_proposal_id"], name: "decidim_proposals_evaluation_assignment_proposal"
    t.index ["evaluator_role_type", "evaluator_role_id"], name: "decidim_proposals_evaluation_assignment_valuator_role"
  end

  create_table "decidim_proposals_participatory_texts", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_component_id", null: false
    t.jsonb "description"
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_component_id"], name: "idx_participatory_texts_on_decidim_component_id"
  end

  create_table "decidim_proposals_proposal_notes", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id", null: false
    t.bigint "decidim_proposal_id", null: false
    t.bigint "parent_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "index_decidim_proposals_proposal_notes_on_created_at"
    t.index ["decidim_author_id"], name: "decidim_proposals_proposal_note_author"
    t.index ["decidim_proposal_id"], name: "decidim_proposals_proposal_note_proposal"
    t.index ["parent_id"], name: "decidim_proposals_proposal_notes_on_parent_id"
  end

  create_table "decidim_proposals_proposal_states", force: :cascade do |t|
    t.jsonb "announcement_title"
    t.string "bg_color", default: "#F6F8FA", null: false
    t.bigint "decidim_component_id", null: false
    t.integer "proposals_count", default: 0, null: false
    t.string "text_color", default: "#4B5058", null: false
    t.jsonb "title"
    t.string "token", null: false
    t.index ["decidim_component_id"], name: "index_decidim_proposals_proposal_states_on_decidim_component_id"
  end

  create_table "decidim_proposals_proposal_votes", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_author_id", null: false
    t.integer "decidim_proposal_id", null: false
    t.boolean "temporary", default: false, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_author_id"], name: "decidim_proposals_proposal_vote_author"
    t.index ["decidim_proposal_id", "decidim_author_id"], name: "decidim_proposals_proposal_vote_proposal_author_unique", unique: true
    t.index ["decidim_proposal_id"], name: "decidim_proposals_proposal_vote_proposal"
  end

  create_table "decidim_proposals_proposals", id: :serial, force: :cascade do |t|
    t.text "address"
    t.jsonb "answer"
    t.datetime "answered_at", precision: nil
    t.jsonb "body"
    t.integer "coauthorships_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.decimal "cost"
    t.jsonb "cost_report"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "created_in_meeting", default: false
    t.integer "decidim_component_id", null: false
    t.integer "decidim_proposals_proposal_state_id"
    t.integer "decidim_scope_id"
    t.datetime "deleted_at"
    t.integer "evaluation_assignments_count", default: 0
    t.jsonb "execution_period"
    t.jsonb "extra"
    t.integer "follows_count", default: 0, null: false
    t.float "latitude"
    t.integer "likes_count", default: 0, null: false
    t.float "longitude"
    t.integer "old_state", default: 0, null: false
    t.string "participatory_text_level"
    t.integer "position"
    t.integer "proposal_notes_count", default: 0, null: false
    t.integer "proposal_votes_count", default: 0, null: false
    t.datetime "published_at", precision: nil
    t.string "reference"
    t.datetime "state_published_at", precision: nil
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "withdrawn_at", precision: nil
    t.index "md5((body)::text)", name: "decidim_proposals_proposal_body_search"
    t.index "md5((title)::text)", name: "decidim_proposals_proposal_title_search"
    t.index ["created_at"], name: "index_decidim_proposals_proposals_on_created_at"
    t.index ["decidim_component_id"], name: "index_decidim_proposals_proposals_on_decidim_component_id"
    t.index ["decidim_scope_id"], name: "index_decidim_proposals_proposals_on_decidim_scope_id"
    t.index ["deleted_at"], name: "index_decidim_proposals_proposals_on_deleted_at"
    t.index ["proposal_votes_count"], name: "index_decidim_proposals_proposals_on_proposal_votes_count"
  end

  create_table "decidim_reminder_deliveries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_reminder_id"
    t.datetime "updated_at", null: false
    t.index ["decidim_reminder_id"], name: "index_decidim_reminder_deliveries_on_decidim_reminder_id"
  end

  create_table "decidim_reminder_records", force: :cascade do |t|
    t.bigint "decidim_reminder_id"
    t.bigint "remindable_id", null: false
    t.string "remindable_type", null: false
    t.integer "state", default: 0, null: false
    t.string "string", default: "active"
    t.index ["decidim_reminder_id"], name: "index_decidim_reminder_records_on_decidim_reminder_id"
    t.index ["remindable_type", "remindable_id"], name: "index_decidim_reminder_records_remindable"
    t.index ["string"], name: "index_decidim_reminder_records_on_string"
  end

  create_table "decidim_reminders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_component_id"
    t.bigint "decidim_user_id", null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_component_id"], name: "index_decidim_reminders_on_decidim_component_id"
    t.index ["decidim_user_id"], name: "index_decidim_reminders_on_decidim_user_id"
  end

  create_table "decidim_reports", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_moderation_id", null: false
    t.integer "decidim_user_id", null: false
    t.text "details"
    t.string "locale"
    t.string "reason", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_moderation_id", "decidim_user_id"], name: "decidim_reports_moderation_user_unique", unique: true
    t.index ["decidim_moderation_id"], name: "decidim_reports_moderation"
    t.index ["decidim_user_id"], name: "decidim_reports_user"
  end

  create_table "decidim_resource_links", id: :serial, force: :cascade do |t|
    t.jsonb "data"
    t.integer "from_id", null: false
    t.string "from_type", null: false
    t.string "name", null: false
    t.integer "to_id", null: false
    t.string "to_type", null: false
    t.index ["from_type", "from_id"], name: "index_decidim_resource_links_on_from_type_and_from_id"
    t.index ["name"], name: "index_decidim_resource_links_on_name"
    t.index ["to_type", "to_id"], name: "index_decidim_resource_links_on_to_type_and_to_id"
  end

  create_table "decidim_resource_permissions", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "permissions", default: {}
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["resource_type", "resource_id"], name: "index_decidim_resource_permissions_on_r_type_and_r_id", unique: true
  end

  create_table "decidim_scope_types", id: :serial, force: :cascade do |t|
    t.integer "decidim_organization_id"
    t.jsonb "name", null: false
    t.jsonb "plural", null: false
    t.index ["decidim_organization_id"], name: "index_decidim_scope_types_on_decidim_organization_id"
  end

  create_table "decidim_scopes", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.jsonb "name", null: false
    t.integer "parent_id"
    t.integer "part_of", default: [], null: false, array: true
    t.integer "scope_type_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id", "code"], name: "index_decidim_scopes_on_decidim_organization_id_and_code", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_scopes_on_decidim_organization_id"
    t.index ["parent_id"], name: "index_decidim_scopes_on_parent_id"
    t.index ["part_of"], name: "index_decidim_scopes_on_part_of", using: :gin
    t.index ["scope_type_id"], name: "index_decidim_scopes_on_scope_type_id"
  end

  create_table "decidim_searchable_resources", force: :cascade do |t|
    t.text "content_a"
    t.text "content_b"
    t.text "content_c"
    t.text "content_d"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "datetime", precision: nil
    t.bigint "decidim_organization_id"
    t.bigint "decidim_participatory_space_id"
    t.string "decidim_participatory_space_type"
    t.bigint "decidim_scope_id"
    t.string "locale", null: false
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_decidim_searchable_resources_on_decidim_organization_id"
    t.index ["decidim_participatory_space_type", "decidim_participatory_space_id"], name: "index_decidim_searchable_resource_on_pspace_type_and_pspace_id"
    t.index ["decidim_scope_id"], name: "index_decidim_searchable_resources_on_decidim_scope_id"
    t.index ["resource_type", "resource_id"], name: "index_decidim_searchable_rsrcs_on_s_type_and_s_id"
  end

  create_table "decidim_share_tokens", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.bigint "decidim_organization_id", null: false
    t.bigint "decidim_user_id", null: false
    t.datetime "expires_at", precision: nil
    t.datetime "last_used_at", precision: nil
    t.boolean "registered_only"
    t.integer "times_used", default: 0
    t.string "token", null: false
    t.bigint "token_for_id", null: false
    t.string "token_for_type", null: false
    t.index ["decidim_organization_id"], name: "index_decidim_share_tokens_on_decidim_organization_id"
    t.index ["decidim_user_id"], name: "index_decidim_share_tokens_on_decidim_user_id"
    t.index ["token_for_type", "token_for_id"], name: "decidim_share_tokens_token_for"
  end

  create_table "decidim_short_links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_organization_id", null: false
    t.string "identifier", limit: 10, null: false
    t.string "mounted_engine_name"
    t.jsonb "params"
    t.string "route_name"
    t.bigint "target_id", null: false
    t.string "target_type", null: false
    t.datetime "updated_at", null: false
    t.index ["decidim_organization_id", "identifier"], name: "idx_decidim_short_links_organization_id_identifier", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_short_links_on_decidim_organization_id"
    t.index ["mounted_engine_name"], name: "index_decidim_short_links_on_mounted_engine_name"
    t.index ["route_name"], name: "index_decidim_short_links_on_route_name"
    t.index ["target_type", "target_id"], name: "index_decidim_short_links_on_target"
  end

  create_table "decidim_sortitions_sortitions", force: :cascade do |t|
    t.jsonb "additional_info"
    t.jsonb "cancel_reason"
    t.integer "cancelled_by_user_id"
    t.datetime "cancelled_on", precision: nil
    t.jsonb "candidate_proposals"
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_author_id", null: false
    t.string "decidim_author_type", null: false
    t.bigint "decidim_component_id"
    t.integer "decidim_proposals_component_id"
    t.datetime "deleted_at"
    t.integer "dice", null: false
    t.string "reference"
    t.datetime "request_timestamp", precision: nil, null: false
    t.jsonb "selected_proposals"
    t.integer "target_items", null: false
    t.jsonb "title"
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "witnesses"
    t.index ["cancelled_by_user_id"], name: "index_decidim_sortitions_sortitions_on_cancelled_by_user_id"
    t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_sortitions_sortitions_on_decidim_author"
    t.index ["decidim_author_id"], name: "index_decidim_sortitions_sortitions_on_decidim_author_id"
    t.index ["decidim_component_id"], name: "index_sortitions__on_feature"
    t.index ["decidim_proposals_component_id"], name: "index_sortitions__on_proposals_feature"
    t.index ["deleted_at"], name: "index_decidim_sortitions_sortitions_on_deleted_at"
  end

  create_table "decidim_static_page_topics", force: :cascade do |t|
    t.jsonb "description", null: false
    t.bigint "organization_id", null: false
    t.boolean "show_in_footer", default: false, null: false
    t.jsonb "title", null: false
    t.integer "weight"
    t.index ["organization_id"], name: "index_decidim_static_page_topics_on_organization_id"
  end

  create_table "decidim_static_pages", id: :serial, force: :cascade do |t|
    t.boolean "allow_public_access", default: false, null: false
    t.jsonb "content", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id"
    t.string "slug", null: false
    t.jsonb "title", null: false
    t.bigint "topic_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "weight"
    t.index ["decidim_organization_id"], name: "index_decidim_static_pages_on_decidim_organization_id"
    t.index ["topic_id"], name: "index_decidim_static_pages_on_topic_id"
  end

  create_table "decidim_surveys_surveys", id: :serial, force: :cascade do |t|
    t.boolean "allow_editing_responses"
    t.boolean "allow_responses"
    t.boolean "allow_unregistered"
    t.jsonb "announcement"
    t.boolean "clean_after_publish"
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_component_id"
    t.datetime "deleted_at"
    t.datetime "ends_at"
    t.datetime "published_at"
    t.datetime "starts_at"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_component_id"], name: "index_decidim_surveys_surveys_on_decidim_component_id"
    t.index ["deleted_at"], name: "index_decidim_surveys_surveys_on_deleted_at"
    t.index ["published_at"], name: "index_decidim_surveys_surveys_on_published_at"
  end

  create_table "decidim_system_admins", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "unlock_token"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_decidim_system_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_decidim_system_admins_on_reset_password_token", unique: true
  end

  create_table "decidim_taxonomies", force: :cascade do |t|
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.bigint "decidim_organization_id", null: false
    t.integer "filter_items_count", default: 0, null: false
    t.integer "filters_count", default: 0, null: false
    t.jsonb "name", default: {}, null: false
    t.bigint "parent_id"
    t.integer "part_of", default: [], null: false, array: true
    t.integer "taxonomizations_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["decidim_organization_id"], name: "index_decidim_taxonomies_on_decidim_organization_id"
    t.index ["parent_id"], name: "index_decidim_taxonomies_on_parent_id"
    t.index ["part_of"], name: "index_decidim_taxonomies_on_part_of", using: :gin
  end

  create_table "decidim_taxonomizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "taxonomizable_id", null: false
    t.string "taxonomizable_type", null: false
    t.bigint "taxonomy_id", null: false
    t.datetime "updated_at", null: false
    t.index ["taxonomizable_type", "taxonomizable_id"], name: "index_taxonomizations_on_taxonomizable"
    t.index ["taxonomy_id", "taxonomizable_id", "taxonomizable_type"], name: "index_taxonomizations_on_id_tid_and_ttype", unique: true
    t.index ["taxonomy_id"], name: "index_decidim_taxonomizations_on_taxonomy_id"
  end

  create_table "decidim_taxonomy_filter_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "taxonomy_filter_id", null: false
    t.bigint "taxonomy_item_id", null: false
    t.datetime "updated_at", null: false
    t.index ["taxonomy_filter_id", "taxonomy_item_id"], name: "index_taxonomy_filter_items_on_filter_id_and_item_id", unique: true
    t.index ["taxonomy_filter_id"], name: "index_decidim_taxonomy_filter_items_on_taxonomy_filter_id"
    t.index ["taxonomy_item_id"], name: "index_decidim_taxonomy_filter_items_on_taxonomy_item_id"
  end

  create_table "decidim_taxonomy_filters", force: :cascade do |t|
    t.integer "components_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "filter_items_count", default: 0, null: false
    t.jsonb "internal_name", default: {}
    t.jsonb "name", default: {}
    t.string "participatory_space_manifests", default: [], null: false, array: true
    t.bigint "root_taxonomy_id", null: false
    t.datetime "updated_at", null: false
    t.index ["root_taxonomy_id"], name: "index_decidim_taxonomy_filters_on_root_taxonomy_id"
  end

  create_table "decidim_taxonomy_scopes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "scope_code"
    t.bigint "scope_id", null: false
    t.bigint "taxonomy_id", null: false
    t.datetime "updated_at", null: false
    t.index ["scope_id"], name: "index_decidim_taxonomy_scopes_on_scope_id", unique: true
    t.index ["taxonomy_id"], name: "index_decidim_taxonomy_scopes_on_taxonomy_id", unique: true
  end

  create_table "decidim_templates_templates", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "decidim_organization_id", null: false
    t.jsonb "description"
    t.json "field_values", default: {}
    t.jsonb "name", null: false
    t.string "target"
    t.bigint "templatable_id"
    t.string "templatable_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_decidim_templates_organization"
    t.index ["templatable_type", "templatable_id"], name: "index_decidim_templates_templatable"
  end

  create_table "decidim_term_customizer_constraints", force: :cascade do |t|
    t.bigint "decidim_organization_id", null: false
    t.bigint "subject_id"
    t.string "subject_type"
    t.bigint "translation_set_id", null: false
    t.index ["decidim_organization_id"], name: "decidim_term_customizer_constraint_organization"
    t.index ["subject_type", "subject_id"], name: "decidim_term_customizer_constraint_subject"
    t.index ["translation_set_id"], name: "decidim_term_customizer_constraint_translation_set"
  end

  create_table "decidim_term_customizer_translation_sets", force: :cascade do |t|
    t.jsonb "name"
  end

  create_table "decidim_term_customizer_translations", force: :cascade do |t|
    t.string "key"
    t.string "locale"
    t.bigint "translation_set_id", null: false
    t.text "value"
    t.index ["translation_set_id"], name: "decidim_term_customizer_translation_translation_set"
  end

  create_table "decidim_user_blocks", force: :cascade do |t|
    t.integer "blocking_user_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_user_id"
    t.text "justification"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_user_id"], name: "index_decidim_user_blocks_on_decidim_user_id"
  end

  create_table "decidim_user_moderations", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_user_id"
    t.integer "report_count", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_user_id"], name: "index_decidim_user_moderations_on_decidim_user_id"
  end

  create_table "decidim_user_reports", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "details"
    t.string "reason"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.integer "user_moderation_id"
  end

  create_table "decidim_users", id: :serial, force: :cascade do |t|
    t.text "about"
    t.datetime "accepted_tos_version", precision: nil
    t.boolean "admin", default: false, null: false
    t.datetime "admin_terms_accepted_at", precision: nil
    t.string "api_key"
    t.integer "block_id"
    t.boolean "blocked", default: false, null: false
    t.datetime "blocked_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.integer "decidim_organization_id"
    t.text "delete_reason"
    t.datetime "deleted_at", precision: nil
    t.datetime "digest_sent_at", precision: nil
    t.string "direct_message_types", default: "all", null: false
    t.string "email", default: ""
    t.boolean "email_on_assigned_proposals", default: true
    t.boolean "email_on_moderations", default: true
    t.string "encrypted_password", default: "", null: false
    t.jsonb "extended_data", default: {}
    t.jsonb "extra"
    t.integer "failed_attempts", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.integer "follows_count", default: 0, null: false
    t.datetime "imported_erased_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.datetime "invitation_created_at", precision: nil
    t.integer "invitation_limit"
    t.datetime "invitation_sent_at", precision: nil
    t.string "invitation_token"
    t.integer "invitations_count", default: 0
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.string "locale"
    t.datetime "locked_at", precision: nil
    t.boolean "managed", default: false, null: false
    t.string "name"
    t.datetime "newsletter_notifications_at", precision: nil
    t.string "newsletter_token", default: ""
    t.string "nickname", limit: 20, default: "", null: false
    t.jsonb "notification_settings", default: {}
    t.string "notification_types", default: "all", null: false
    t.string "notifications_sending_frequency", default: "daily"
    t.jsonb "officialized_as"
    t.datetime "officialized_at", precision: nil
    t.datetime "password_updated_at", precision: nil
    t.string "personal_url"
    t.string "previous_passwords", default: [], array: true
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "roles", default: [], array: true
    t.string "session_token"
    t.integer "sign_in_count", default: 0, null: false
    t.string "type", null: false
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["confirmation_token"], name: "index_decidim_users_on_confirmation_token", unique: true
    t.index ["decidim_organization_id"], name: "index_decidim_users_on_decidim_organization_id"
    t.index ["email", "decidim_organization_id"], name: "index_decidim_users_on_email_and_decidim_organization_id", unique: true, where: "((deleted_at IS NULL) AND (managed = false) AND ((type)::text = 'Decidim::User'::text))"
    t.index ["id", "type"], name: "index_decidim_users_on_id_and_type"
    t.index ["invitation_token"], name: "index_decidim_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_decidim_users_on_invitations_count"
    t.index ["invited_by_id", "invited_by_type"], name: "index_decidim_users_on_invited_by_id_and_invited_by_type"
    t.index ["invited_by_id"], name: "index_decidim_users_on_invited_by_id"
    t.index ["nickname", "decidim_organization_id"], name: "index_decidim_users_on_nickame_and_decidim_organization_id", unique: true, where: "((deleted_at IS NULL) AND (managed = false))"
    t.index ["notifications_sending_frequency"], name: "index_decidim_users_on_notifications_sending_frequency"
    t.index ["officialized_at"], name: "index_decidim_users_on_officialized_at"
    t.index ["reset_password_token"], name: "index_decidim_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_decidim_users_on_unlock_token", unique: true
  end

  create_table "decidim_verifications_conflicts", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "current_user_id"
    t.bigint "managed_user_id"
    t.boolean "solved", default: false
    t.integer "times", default: 0
    t.string "unique_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["current_user_id"], name: "authorization_current_user"
    t.index ["managed_user_id"], name: "authorization_managed_user"
  end

  create_table "decidim_verifications_csv_data", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_organization_id"
    t.string "email"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_verifications_csv_census_to_organization"
  end

  create_table "decidim_vocdoni_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_vocdoni_question_id"
    t.jsonb "description"
    t.jsonb "title"
    t.datetime "updated_at", null: false
    t.integer "value"
    t.integer "votes"
    t.integer "weight"
    t.index ["decidim_vocdoni_question_id"], name: "index_decidim_vocdoni_answers_on_decidim_vocdoni_question_id"
  end

  create_table "decidim_vocdoni_elections", force: :cascade do |t|
    t.datetime "blocked_at", precision: nil
    t.jsonb "census_attributes", default: {}
    t.datetime "census_last_updated_at", precision: nil
    t.datetime "created_at", null: false
    t.bigint "decidim_component_id"
    t.jsonb "description"
    t.jsonb "election_type", default: {}
    t.datetime "end_time", precision: nil
    t.boolean "internal_census", default: false, null: false
    t.integer "last_census_update_records_added"
    t.datetime "published_at", precision: nil
    t.datetime "start_time", precision: nil
    t.string "status"
    t.string "stream_uri"
    t.jsonb "title"
    t.datetime "updated_at", null: false
    t.string "verification_types", default: [], array: true
    t.string "vocdoni_election_id"
    t.index ["decidim_component_id"], name: "index_decidim_vocdoni_elections_on_decidim_component_id"
  end

  create_table "decidim_vocdoni_questions", force: :cascade do |t|
    t.integer "answers_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.bigint "decidim_vocdoni_election_id"
    t.jsonb "description"
    t.jsonb "title"
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["decidim_vocdoni_election_id"], name: "index_decidim_vocdoni_questions_on_decidim_vocdoni_election_id"
  end

  create_table "decidim_vocdoni_voters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "decidim_vocdoni_election_id"
    t.string "email"
    t.boolean "in_vocdoni_census", default: false, null: false
    t.string "token"
    t.datetime "updated_at", null: false
    t.string "wallet_address"
    t.index ["decidim_vocdoni_election_id"], name: "index_decidim_vocdoni_voters_on_decidim_vocdoni_election_id"
  end

  create_table "decidim_vocdoni_wallets", force: :cascade do |t|
    t.bigint "decidim_organization_id"
    t.string "private_key"
    t.index ["decidim_organization_id"], name: "index_decidim_vocdoni_wallets_on_decidim_organization_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "application_id", null: false
    t.string "code_challenge"
    t.string "code_challenge_method"
    t.datetime "created_at", precision: nil, null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.integer "resource_owner_id", null: false
    t.datetime "revoked_at", precision: nil
    t.string "scopes"
    t.string "token", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "application_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "expires_in"
    t.string "previous_refresh_token", default: "", null: false
    t.string "refresh_token"
    t.integer "resource_owner_id"
    t.datetime "revoked_at", precision: nil
    t.string "scopes"
    t.string "token", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "decidim_organization_id"
    t.string "name", null: false
    t.string "organization_name", null: false
    t.string "organization_url", null: false
    t.text "redirect_uri", null: false
    t.boolean "refresh_tokens_enabled", default: false
    t.string "scopes", default: "", null: false
    t.string "secret", null: false
    t.string "type"
    t.string "uid", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["decidim_organization_id"], name: "index_oauth_applications_on_decidim_organization_id"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "event", null: false
    t.integer "item_id", null: false
    t.string "item_type", null: false
    t.jsonb "object"
    t.jsonb "object_changes"
    t.text "old_object_changes"
    t.string "whodunnit"
    t.index ["item_id", "item_type"], name: "index_versions_on_item_id_and_item_type"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "decidim_area_types", "decidim_organizations"
  add_foreign_key "decidim_areas", "decidim_area_types", column: "area_type_id"
  add_foreign_key "decidim_areas", "decidim_organizations"
  add_foreign_key "decidim_assemblies_settings", "decidim_organizations"
  add_foreign_key "decidim_attachments", "decidim_attachment_collections", column: "attachment_collection_id", name: "fk_decidim_attachments_attachment_collection_id", on_delete: :nullify
  add_foreign_key "decidim_authorization_transfer_records", "decidim_authorization_transfers", column: "transfer_id"
  add_foreign_key "decidim_authorization_transfers", "decidim_authorizations", column: "authorization_id"
  add_foreign_key "decidim_authorization_transfers", "decidim_users", column: "source_user_id"
  add_foreign_key "decidim_authorization_transfers", "decidim_users", column: "user_id"
  add_foreign_key "decidim_authorizations", "decidim_users"
  add_foreign_key "decidim_awesome_authorization_groups", "decidim_organizations"
  add_foreign_key "decidim_awesome_authorization_members", "decidim_awesome_authorization_groups", column: "authorization_group_id"
  add_foreign_key "decidim_awesome_config_constraints", "decidim_awesome_config"
  add_foreign_key "decidim_awesome_editor_images", "decidim_organizations"
  add_foreign_key "decidim_awesome_editor_images", "decidim_users", column: "decidim_author_id"
  add_foreign_key "decidim_budgets_budgets", "decidim_scopes"
  add_foreign_key "decidim_budgets_orders", "decidim_budgets_budgets"
  add_foreign_key "decidim_budgets_projects", "decidim_budgets_budgets"
  add_foreign_key "decidim_categorizations", "decidim_categories"
  add_foreign_key "decidim_debates_debates", "decidim_scopes"
  add_foreign_key "decidim_editor_images", "decidim_organizations"
  add_foreign_key "decidim_editor_images", "decidim_users", column: "decidim_author_id"
  add_foreign_key "decidim_elections_questions", "decidim_elections_elections", column: "election_id"
  add_foreign_key "decidim_elections_response_options", "decidim_elections_questions", column: "question_id"
  add_foreign_key "decidim_elections_voters", "decidim_elections_elections", column: "election_id"
  add_foreign_key "decidim_elections_votes", "decidim_elections_questions", column: "question_id"
  add_foreign_key "decidim_elections_votes", "decidim_elections_response_options", column: "response_option_id"
  add_foreign_key "decidim_identities", "decidim_organizations"
  add_foreign_key "decidim_initiatives_settings", "decidim_organizations"
  add_foreign_key "decidim_kids_minor_accounts", "decidim_users", column: "decidim_minor_id"
  add_foreign_key "decidim_kids_minor_accounts", "decidim_users", column: "decidim_tutor_id"
  add_foreign_key "decidim_navigation_maps_blueprint_areas", "decidim_navigation_maps_blueprints"
  add_foreign_key "decidim_navigation_maps_blueprints", "decidim_content_blocks"
  add_foreign_key "decidim_navigation_maps_blueprints", "decidim_organizations"
  add_foreign_key "decidim_newsletters", "decidim_users", column: "author_id"
  add_foreign_key "decidim_participatory_process_steps", "decidim_participatory_processes"
  add_foreign_key "decidim_participatory_processes", "decidim_organizations"
  add_foreign_key "decidim_participatory_processes", "decidim_scope_types"
  add_foreign_key "decidim_proposals_proposals", "decidim_proposals_proposal_states"
  add_foreign_key "decidim_reminder_deliveries", "decidim_reminders"
  add_foreign_key "decidim_reminder_records", "decidim_reminders"
  add_foreign_key "decidim_reminders", "decidim_components"
  add_foreign_key "decidim_reminders", "decidim_users"
  add_foreign_key "decidim_scope_types", "decidim_organizations"
  add_foreign_key "decidim_scopes", "decidim_organizations"
  add_foreign_key "decidim_scopes", "decidim_organizations", name: "decidim_scopes_decidim_organization_id_fkey"
  add_foreign_key "decidim_scopes", "decidim_scope_types", column: "scope_type_id"
  add_foreign_key "decidim_scopes", "decidim_scope_types", column: "scope_type_id", name: "decidim_scopes_scope_type_id_fkey"
  add_foreign_key "decidim_scopes", "decidim_scopes", column: "parent_id"
  add_foreign_key "decidim_scopes", "decidim_scopes", column: "parent_id", name: "decidim_scopes_parent_id_fkey"
  add_foreign_key "decidim_static_pages", "decidim_organizations"
  add_foreign_key "decidim_taxonomy_filter_items", "decidim_taxonomies", column: "taxonomy_item_id"
  add_foreign_key "decidim_taxonomy_filters", "decidim_taxonomies", column: "root_taxonomy_id"
  add_foreign_key "decidim_taxonomy_scopes", "decidim_taxonomies", column: "taxonomy_id"
  add_foreign_key "decidim_term_customizer_constraints", "decidim_organizations"
  add_foreign_key "decidim_term_customizer_constraints", "decidim_term_customizer_translation_sets", column: "translation_set_id"
  add_foreign_key "decidim_term_customizer_translations", "decidim_term_customizer_translation_sets", column: "translation_set_id"
  add_foreign_key "decidim_user_blocks", "decidim_users"
  add_foreign_key "decidim_user_blocks", "decidim_users", column: "blocking_user_id"
  add_foreign_key "decidim_user_moderations", "decidim_users"
  add_foreign_key "decidim_user_reports", "decidim_user_moderations", column: "user_moderation_id"
  add_foreign_key "decidim_user_reports", "decidim_users", column: "user_id"
  add_foreign_key "decidim_users", "decidim_organizations"
  add_foreign_key "decidim_verifications_conflicts", "decidim_users", column: "current_user_id"
  add_foreign_key "decidim_verifications_conflicts", "decidim_users", column: "managed_user_id"
  add_foreign_key "decidim_verifications_csv_data", "decidim_organizations"
  add_foreign_key "decidim_vocdoni_voters", "decidim_vocdoni_elections"
  add_foreign_key "decidim_vocdoni_wallets", "decidim_organizations"
  add_foreign_key "oauth_access_grants", "decidim_users", column: "resource_owner_id"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "decidim_users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_applications", "decidim_organizations"
end
