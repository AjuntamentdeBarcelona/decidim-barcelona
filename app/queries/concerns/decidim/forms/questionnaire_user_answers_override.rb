# frozen_string_literal: true

module Decidim
  module Forms
    module QuestionnaireUserAnswersOverride
      extend ActiveSupport::Concern

      included do
        # Override method sorting answers by created_at to match the order of the admin page
        def query
          answers = Answer.not_separator
                          .not_title_and_description
                          .joins(:question)
                          .where(questionnaire: @questionnaire)

          answers.sort_by { |answer| answer.question.position }.group_by { |a| a.user || a.session_token }.values
                 .sort_by { |question_answers| question_answers.map(&:created_at).min }
        end
      end
    end
  end
end
