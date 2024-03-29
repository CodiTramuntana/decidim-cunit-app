# frozen_string_literal: true

workers Integer(ENV.fetch("WEB_CONCURRENCY", nil) || 1)
threads_count = Integer(ENV.fetch("MAX_THREADS", nil) || 5)
threads threads_count, threads_count
stdout_redirect "log/puma.log", "log/puma_error.log", true
pidfile "tmp/pids/puma.pid"
state_path "tmp/pids/puma.state"

# These make it crash on Heroku
# pidfile "tmp/pids/puma.pid"
# state_path "tmp/pids/puma.state"

preload_app!

rackup DefaultRackup
port ENV.fetch("PORT", nil) || 3000
env = ENV.fetch("RACK_ENV", nil) || ENV.fetch("RAILS_ENV", nil) || :production
environment env
daemonize [:production, :staging, :integration].include?(env.to_sym)

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
