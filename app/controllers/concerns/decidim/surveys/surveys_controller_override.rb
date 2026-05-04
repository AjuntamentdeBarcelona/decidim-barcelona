# frozen_string_literal: true

module Decidim
  module Surveys
    module SurveysControllerOverride
      extend ActiveSupport::Concern

      included do
        def check_permissions
          render :no_permission unless action_authorized_to(:respond, resource: survey).ok?
        end
      end
    end
  end
end
