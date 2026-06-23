# frozen_string_literal: true

module Decidim
  module Forms
    module QuestionOverride
      extend ActiveSupport::Concern

      included do
        has_many :display_conditions_for_other_questions,
                 class_name: "DisplayCondition",
                 foreign_key: "decidim_condition_question_id",
                 dependent: :destroy,
                 inverse_of: :condition_question,
                 counter_cache: :display_conditions_for_other_questions_count
      end
    end
  end
end
