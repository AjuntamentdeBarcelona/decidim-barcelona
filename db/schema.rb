# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170125163933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "decidim_admin_participatory_process_user_roles", force: :cascade do |t|
    t.integer  "decidim_user_id"
    t.integer  "decidim_participatory_process_id"
    t.string   "role"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["decidim_participatory_process_id", "decidim_user_id", "role"], name: "index_unique_user_and_process_role", unique: true, using: :btree
  end

  create_table "decidim_attachments", force: :cascade do |t|
    t.jsonb    "title",            null: false
    t.jsonb    "description",      null: false
    t.string   "file",             null: false
    t.string   "content_type",     null: false
    t.string   "file_size",        null: false
    t.integer  "attached_to_id",   null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "attached_to_type", null: false
    t.index ["attached_to_id", "attached_to_type"], name: "index_decidim_attachments_on_attached_to", using: :btree
  end

  create_table "decidim_authorizations", force: :cascade do |t|
    t.string   "name",            null: false
    t.jsonb    "metadata"
    t.integer  "decidim_user_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "unique_id"
    t.index ["decidim_user_id", "name"], name: "index_decidim_authorizations_on_decidim_user_id_and_name", unique: true, using: :btree
    t.index ["decidim_user_id"], name: "index_decidim_authorizations_on_decidim_user_id", using: :btree
  end

  create_table "decidim_categories", force: :cascade do |t|
    t.jsonb   "name",                             null: false
    t.jsonb   "description",                      null: false
    t.integer "parent_id"
    t.integer "decidim_participatory_process_id"
    t.index ["decidim_participatory_process_id"], name: "index_decidim_categories_on_decidim_participatory_process_id", using: :btree
    t.index ["parent_id"], name: "index_decidim_categories_on_parent_id", using: :btree
  end

  create_table "decidim_comments_comment_votes", force: :cascade do |t|
    t.integer  "weight",             null: false
    t.integer  "decidim_comment_id", null: false
    t.integer  "decidim_author_id",  null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["decidim_author_id"], name: "decidim_comments_comment_vote_author", using: :btree
    t.index ["decidim_comment_id", "decidim_author_id"], name: "decidim_comments_comment_vote_comment_author_unique", unique: true, using: :btree
    t.index ["decidim_comment_id"], name: "decidim_comments_comment_vote_comment", using: :btree
  end

  create_table "decidim_comments_comments", force: :cascade do |t|
    t.text     "body",                                 null: false
    t.string   "decidim_commentable_type",             null: false
    t.integer  "decidim_commentable_id",               null: false
    t.integer  "decidim_author_id",                    null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "depth",                    default: 0, null: false
    t.integer  "alignment",                default: 0, null: false
    t.integer  "decidim_user_group_id"
    t.index ["created_at"], name: "index_decidim_comments_comments_on_created_at", using: :btree
    t.index ["decidim_author_id"], name: "decidim_comments_comment_author", using: :btree
    t.index ["decidim_commentable_type", "decidim_commentable_id"], name: "decidim_comments_comment_commentable", using: :btree
  end

  create_table "decidim_features", force: :cascade do |t|
    t.string  "manifest_name"
    t.jsonb   "name"
    t.integer "decidim_participatory_process_id"
    t.jsonb   "settings",                         default: {}
    t.index ["decidim_participatory_process_id"], name: "index_decidim_features_on_decidim_participatory_process_id", using: :btree
  end

  create_table "decidim_identities", force: :cascade do |t|
    t.string  "provider",        null: false
    t.string  "uid",             null: false
    t.integer "decidim_user_id", null: false
    t.index ["decidim_user_id"], name: "index_decidim_identities_on_decidim_user_id", using: :btree
    t.index ["provider", "uid"], name: "index_decidim_identities_on_provider_and_uid", unique: true, using: :btree
  end

  create_table "decidim_meetings_meetings", force: :cascade do |t|
    t.jsonb    "title"
    t.jsonb    "description"
    t.jsonb    "short_description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "address"
    t.jsonb    "location"
    t.jsonb    "location_hints"
    t.integer  "decidim_feature_id"
    t.integer  "decidim_author_id"
    t.integer  "decidim_scope_id"
    t.integer  "decidim_category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.jsonb    "closing_report"
    t.integer  "attendees_count"
    t.integer  "contributions_count"
    t.text     "attending_organizations"
    t.time     "closed_at"
    t.index ["decidim_author_id"], name: "index_decidim_meetings_meetings_on_decidim_author_id", using: :btree
    t.index ["decidim_category_id"], name: "index_decidim_meetings_meetings_on_decidim_category_id", using: :btree
    t.index ["decidim_feature_id"], name: "index_decidim_meetings_meetings_on_decidim_feature_id", using: :btree
    t.index ["decidim_scope_id"], name: "index_decidim_meetings_meetings_on_decidim_scope_id", using: :btree
  end

  create_table "decidim_organizations", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "host",                             null: false
    t.string   "default_locale",                   null: false
    t.string   "available_locales", default: [],                array: true
    t.jsonb    "welcome_text"
    t.string   "homepage_image"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.jsonb    "description"
    t.string   "logo"
    t.string   "twitter_handler"
    t.boolean  "show_statistics",   default: true
    t.index ["host"], name: "index_decidim_organizations_on_host", unique: true, using: :btree
    t.index ["name"], name: "index_decidim_organizations_on_name", unique: true, using: :btree
  end

  create_table "decidim_pages_pages", force: :cascade do |t|
    t.jsonb    "title"
    t.jsonb    "body"
    t.integer  "decidim_feature_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["decidim_feature_id"], name: "index_decidim_pages_pages_on_decidim_feature_id", using: :btree
  end

  create_table "decidim_participatory_process_steps", force: :cascade do |t|
    t.jsonb    "title",                                            null: false
    t.jsonb    "short_description"
    t.jsonb    "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "decidim_participatory_process_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "active",                           default: false
    t.integer  "position"
    t.index ["decidim_participatory_process_id", "active"], name: "unique_index_to_avoid_duplicate_active_steps", unique: true, where: "(active = true)", using: :btree
    t.index ["decidim_participatory_process_id", "position"], name: "index_unique_position_for_process", unique: true, using: :btree
    t.index ["decidim_participatory_process_id"], name: "index_decidim_processes_steps__on_decidim_process_id", using: :btree
    t.index ["position"], name: "index_order_by_position_for_steps", using: :btree
  end

  create_table "decidim_participatory_processes", force: :cascade do |t|
    t.string   "slug",                                    null: false
    t.string   "hashtag"
    t.integer  "decidim_organization_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.jsonb    "title",                                   null: false
    t.jsonb    "subtitle",                                null: false
    t.jsonb    "short_description",                       null: false
    t.jsonb    "description",                             null: false
    t.string   "hero_image"
    t.string   "banner_image"
    t.boolean  "promoted",                default: false
    t.datetime "published_at"
    t.index ["decidim_organization_id", "slug"], name: "index_unique_process_slug_and_organization", unique: true, using: :btree
    t.index ["decidim_organization_id"], name: "index_decidim_processes_on_decidim_organization_id", using: :btree
  end

  create_table "decidim_proposals_proposal_votes", force: :cascade do |t|
    t.integer  "decidim_proposal_id", null: false
    t.integer  "decidim_author_id",   null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["decidim_author_id"], name: "decidim_proposals_proposal_vote_author", using: :btree
    t.index ["decidim_proposal_id", "decidim_author_id"], name: "decidim_proposals_proposal_vote_proposal_author_unique", unique: true, using: :btree
    t.index ["decidim_proposal_id"], name: "decidim_proposals_proposal_vote_proposal", using: :btree
  end

  create_table "decidim_proposals_proposals", force: :cascade do |t|
    t.text     "title",                             null: false
    t.text     "body",                              null: false
    t.integer  "decidim_feature_id",                null: false
    t.integer  "decidim_author_id"
    t.integer  "decidim_category_id"
    t.integer  "decidim_scope_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "proposal_votes_count",  default: 0, null: false
    t.integer  "decidim_user_group_id"
    t.index ["body"], name: "decidim_proposals_proposal_body_search", using: :btree
    t.index ["decidim_author_id"], name: "index_decidim_proposals_proposals_on_decidim_author_id", using: :btree
    t.index ["decidim_category_id"], name: "index_decidim_proposals_proposals_on_decidim_category_id", using: :btree
    t.index ["decidim_feature_id"], name: "index_decidim_proposals_proposals_on_decidim_feature_id", using: :btree
    t.index ["decidim_scope_id"], name: "index_decidim_proposals_proposals_on_decidim_scope_id", using: :btree
    t.index ["title"], name: "decidim_proposals_proposal_title_search", using: :btree
  end

  create_table "decidim_resource_links", force: :cascade do |t|
    t.string  "from_type", null: false
    t.integer "from_id",   null: false
    t.string  "to_type",   null: false
    t.integer "to_id",     null: false
    t.string  "name",      null: false
    t.jsonb   "data"
    t.index ["from_type", "from_id"], name: "index_decidim_resource_links_on_from_type_and_from_id", using: :btree
    t.index ["name"], name: "index_decidim_resource_links_on_name", using: :btree
    t.index ["to_type", "to_id"], name: "index_decidim_resource_links_on_to_type_and_to_id", using: :btree
  end

  create_table "decidim_scopes", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "decidim_organization_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["decidim_organization_id"], name: "index_decidim_scopes_on_decidim_organization_id", using: :btree
    t.index ["name"], name: "index_decidim_scopes_on_name", using: :btree
  end

  create_table "decidim_static_pages", force: :cascade do |t|
    t.jsonb    "title",                   null: false
    t.string   "slug",                    null: false
    t.jsonb    "content",                 null: false
    t.integer  "decidim_organization_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["decidim_organization_id"], name: "index_decidim_static_pages_on_decidim_organization_id", using: :btree
  end

  create_table "decidim_system_admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_decidim_system_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_decidim_system_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "decidim_user_group_memberships", force: :cascade do |t|
    t.integer  "decidim_user_id",       null: false
    t.integer  "decidim_user_group_id", null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["decidim_user_group_id"], name: "index_decidim_user_group_memberships_on_decidim_user_group_id", using: :btree
    t.index ["decidim_user_id", "decidim_user_group_id"], name: "decidim_user_group_memberships_unique_user_and_group_ids", unique: true, using: :btree
    t.index ["decidim_user_id"], name: "index_decidim_user_group_memberships_on_decidim_user_id", using: :btree
  end

  create_table "decidim_user_groups", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "document_number",                 null: false
    t.string   "phone",                           null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "verified",        default: false
    t.string   "avatar"
  end

  create_table "decidim_users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",       default: 0
    t.integer  "decidim_organization_id"
    t.string   "roles",                   default: [],              array: true
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                                 null: false
    t.string   "locale"
    t.string   "avatar"
    t.index ["confirmation_token"], name: "index_decidim_users_on_confirmation_token", unique: true, using: :btree
    t.index ["decidim_organization_id"], name: "index_decidim_users_on_decidim_organization_id", using: :btree
    t.index ["email"], name: "index_decidim_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_decidim_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_decidim_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_decidim_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_decidim_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "decidim_authorizations", "decidim_users"
  add_foreign_key "decidim_participatory_process_steps", "decidim_participatory_processes"
  add_foreign_key "decidim_participatory_processes", "decidim_organizations"
  add_foreign_key "decidim_scopes", "decidim_organizations"
  add_foreign_key "decidim_static_pages", "decidim_organizations"
  add_foreign_key "decidim_users", "decidim_organizations"
end
