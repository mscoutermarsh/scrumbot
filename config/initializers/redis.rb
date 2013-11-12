if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
else
  Redis.current = Redis.new
end

REDIS = Redis.current

# set session store to use redis
servers = ENV["REDISTOGO_URL"] || "redis://localhost:6379"
Scrumlogs::Application.config.session_store :redis_store, :servers => servers, key: '_scrumlogs_session'
