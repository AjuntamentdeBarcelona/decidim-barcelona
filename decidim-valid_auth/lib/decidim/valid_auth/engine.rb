# frozen_string_literal: true

module Decidim
  module ValidAuth
    # This is an engine that performs an example user authorization.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::ValidAuth
    end
  end
end
