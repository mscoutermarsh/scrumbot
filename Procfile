custom_web: bundle exec puma -e $RACK_ENV -b unix:///tmp/web_server.sock --pidfile /tmp/web_server.pid -C config/puma.rb -d
worker: bundle exec sidekiq -e $RAILS_ENV -C config/sidekiq.yml