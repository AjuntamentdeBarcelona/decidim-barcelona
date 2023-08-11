# frozen_string_literal: true

module Decidim
  module Dataviz
    # This is the engine that runs on the admin interface of decidim-dataviz.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Dataviz::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      def load_seed
        nil
      end
    end
  end
end
