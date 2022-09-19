# frozen_string_literal: true

module Decidim
  module Overrides
    module TermsCustomizer
      module Context
        # Override resolve! method rescuing the 404 error on current_participatory_space introduced in
        # https://github.com/AjuntamentdeBarcelona/decidim/commit/2a241d9d5990c057a85a7431767f434d1729e288
        module ControllerContext
          def resolve!
            env = data[:headers].env
            controller = env["action_controller.instance"]

            @organization = env["decidim.current_organization"]

            # E.g. at the participatory process controller the
            # `decidim.current_participatory_space` environment variable has not
            # been set. Therefore, we need to fetch it directly from the
            # controller using its private method. In some edge cases this may not
            # be implemented (https://github.com/mainio/decidim-module-term_customizer/issues/28)
            # in which case we do not have access to the participatory space.
            if controller.respond_to?(:current_participatory_space, true)
              begin
                @space = controller.send(
                  :current_participatory_space
                )
              rescue ActiveRecord::RecordNotFound
                @space = nil
              end
            end
            @space ||= env["decidim.current_participatory_space"]

            @component = env["decidim.current_component"]
          end
        end
      end
    end
  end
end
