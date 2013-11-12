if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
else
  Redis.current = Redis.new
end

REDIS = Redis.current