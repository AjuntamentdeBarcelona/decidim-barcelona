# frozen_string_literal: true

module Decidim
  module Overrides
    module Forms
      module UserAnswersSerializer

        private

        def hash_for(answer)
          {
            answer_translated_attribute_name(:id) => answer&.session_token,
            answer_translated_attribute_name(:user_status) => answer_translated_attribute_name(answer&.decidim_user_id.present? ? "registered" : "unregistered"),
            answer_translated_attribute_name(:ip_hash) => answer&.ip_hash,
            answer_translated_attribute_name(:created_at) => answer&.created_at
          }
        end

        def questions_hash
          questionnaire_id = @answers.first&.decidim_questionnaire_id
          return {} unless questionnaire_id

          questions = Decidim::Forms::Question.where(decidim_questionnaire_id: questionnaire_id).order(:position)
          return {} if questions.none?

          questions.each.inject({}) do |serialized, question|
            serialized.update(
              translated_question_key(question.position, question.body) => ""
            )
          end
        end
      end
    end
  end
end
