# frozen_string_literal: true

module Decidim
  module Budgets
    module BudgetListItemCellOverride
      extend ActiveSupport::Concern

      included do
        def button_text
          key = if voting_finished?
                  :see_more_results
                elsif voting_open? && !voted?
                  progress? ? :progress : :vote
                else
                  :check_more_projects
                end

          t(key, scope: i18n_scope)
        end
      end
    end
  end
end
