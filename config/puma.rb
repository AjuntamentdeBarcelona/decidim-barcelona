# frozen_string_literal: true

# avoid workers for development so console and byebug are working
workers Integer(ENV.fetch("WEB_CONCURRENCY", nil) || 2) if ENV["WEB_CONCURRENCY"]
threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", nil) || 5)
threads threads_count, threads_count

preload_app!

port ENV.fetch("PORT", nil) || 3000
environment ENV.fetch("RACK_ENV", nil) || "development"

before_fork do
  require "barnes"

  Barnes.start
end
