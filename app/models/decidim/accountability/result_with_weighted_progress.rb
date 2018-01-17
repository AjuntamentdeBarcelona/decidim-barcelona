# frozen_string_literal: true

module Decidim
  module Accountability
    # The data store for a Result in the Decidim::Accountability component. It stores a
    # title, description and any other useful information to render a custom result.
    class ResultWithWeightedProgress < Decidim::Accountability::Result
      def update_progress!
        if children.length > 1 && children.pluck(:weight).any? {|weight| weight == 1.0 }
          # Not using weights
          self.progress = children.average(:progress)
        else
          children_sum = children.sum{ |r| (r.progress.to_f*r.weight) / 100.0 }
          self.progress = children_sum * 100
        end
        save!
      end
    end
  end
end
