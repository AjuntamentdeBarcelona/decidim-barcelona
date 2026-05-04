# frozen_string_literal: true

module Decidim
  module Surveys
    module SurveyHelperOverride
      extend ActiveSupport::Concern

      included do
        def authorizations
          @authorizations ||= action_authorized_to(:respond, resource: questionnaire_for)
        end
      end
    end
  end
end
