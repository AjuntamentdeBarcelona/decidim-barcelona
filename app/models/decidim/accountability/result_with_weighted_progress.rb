# frozen_string_literal: true

module Decidim
  module Accountability
    # The data store for a Result in the Decidim::Accountability component. It stores a
    # title, description and any other useful information to render a custom result.
    class ResultWithWeightedProgress < Decidim::Accountability::Result
      include Decidim::TranslatableResource

      translatable_fields :title, :description

      belongs_to :parent, class_name: "Decidim::Accountability::ResultWithWeightedProgress", inverse_of: :children, optional: true, counter_cache: :children_count

      # There are two ways to update parent's progress:
      #   - using weights, in which case each progress is multiplied by the weigth and them summed
      #   - not using weights, and using the average of progress of each children
      def update_progress!
        self.progress = if children_use_weighted_progress?
                          children.sum { |result| result.progress.to_f * result.weight }
                        else
                          children.average(:progress)
                        end
        save!
      end

      private

      # When a row uses weight 1 and there's more than one, weight shouldn't be considered
      # rubocop:disable Lint/FloatComparison
      def children_use_weighted_progress?
        children.length == 1 || children.pluck(:weight).none? { |weight| weight == 1.0 }
      end
      # rubocop:enable Lint/FloatComparison
    end
  end
end
