# frozen_string_literal: true
module Decidim
  module Debates
    # The data store for a Debate in the Decidim::Debates component. It stores a
    # title, description and any other useful information to render a custom
    # debate.
    class Debate < Debates::ApplicationRecord
      include Decidim::Authorable
      belongs_to :feature, foreign_key: "decidim_feature_id", class_name: Decidim::Feature
      belongs_to :scope, foreign_key: "decidim_scope_id", class_name: Decidim::Scope
      belongs_to :category, foreign_key: "decidim_category_id", class_name: Decidim::Category
      has_one :organization, through: :feature

      validate :category_belongs_to_organization
      validate :author_belongs_to_organization
      validates :title, presence: true

      def author_name
        user_group&.name || author&.name || I18n.t("decidim.debates.models.debate.fields.official_debate")
      end

      def author_avatar_url
        author&.avatar&.url || ActionController::Base.helpers.asset_path("decidim/default-avatar.svg")
      end

      private

      def author_belongs_to_organization
        return unless author
        errors.add(:author, :invalid) unless Decidim::User.where(decidim_organization_id: feature.organization.id, id: author.id).exists?
      end

      def category_belongs_to_organization
        return unless category
        errors.add(:category, :invalid) unless feature.categories.where(id: category.id).exists?
      end
    end
  end
end
