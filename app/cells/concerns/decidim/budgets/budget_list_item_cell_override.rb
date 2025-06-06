# frozen_string_literal: true

module Decidim
  module Budgets
    module BudgetListItemCellOverride
      extend ActiveSupport::Concern

      included do
        def button_text
          key = if voting_finished?
                  :see_results
                elsif voting_open? && !voted?
                  progress? ? :progress : :vote
                else
                  :show
                end

          t(key, scope: i18n_scope)
        end
      end
    end
  end
end
