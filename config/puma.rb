# frozen_string_literal: true

workers Integer(ENV["WEB_CONCURRENCY"] || 2)
threads_count = Integer(ENV["RAILS_MAX_THREADS"] || 5)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port ENV["PORT"] || 3000
environment ENV["RACK_ENV"] || "development"

before_fork do
  require "puma_worker_killer"

  PumaWorkerKiller.enable_rolling_restart
end
