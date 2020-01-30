# frozen_string_literal: true

module Decidim
  module Stats
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Stats
    end
  end
end
