# frozen_string_literal: true

module Decidim
  module Forms
    module QuestionnaireUserResponsesOverride
      extend ActiveSupport::Concern

      included do
        # Override method sorting answers by created_at to match the order of the admin page
        def query
          responses = Response.not_separator
                          .not_title_and_description
                          .joins(:question)
                          .where(questionnaire: @questionnaire)

          responses.sort_by { |response| response.question.position.to_i }.group_by { |a| a.user || a.session_token }.values
                 .sort_by { |question_responses| question_responses.map(&:created_at).min }
        end
      end
    end
  end
end
