preload_app!
 
min_threads = Integer(ENV['MIN_THREADS'] || 0)
max_threads = Integer(ENV['MAX_THREADS'] || 5)
 
threads min_threads, max_threads
workers Integer(ENV['WORKER_COUNT'] || 4 )
 
on_worker_boot do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5
    ActiveRecord::Base.establish_connection
  end
end