# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `environment` that Puma will run in.
# Defaults to development
rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/tmp"

if rails_env == 'production'
  # Logging
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"

  # Change to match your CPU core count
  workers ENV.fetch("WEB_CONCURRENCY") { 2 }

  preload_app!

  # Set up socket location
  bind "unix://#{shared_dir}/sockets/puma.sock"

  before_fork do
    # app does not use database, uncomment when needed
    # ActiveRecord::Base.connection_pool.disconnect!
  end

  on_worker_boot do
    ActiveSupport.on_load(:active_record) do
      # app does not use database, uncomment when needed
      # db_url = ENV.fetch('DATABASE_URL')
      # puts "puma: connecting to DB at #{db_url}"
      # ActiveRecord::Base.establish_connection(db_url)
    end
  end
elsif rails_env == "development"
  # Specifies the `port` that Puma will listen on to receive requests; default is 3000.
  port        ENV.fetch("PORT") { 3000 }
end
