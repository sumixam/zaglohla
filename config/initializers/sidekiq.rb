require 'redis'
require 'sidekiq/middleware/i18n'

request_thread_count = 32 # take it from puma config
timeout = 1
redis_conf = {
  host: "127.0.0.1",
  port: "6379",
}

Redis.current =
  ConnectionPool::Wrapper.new(size: request_thread_count, timeout: timeout) do
    Redis.new(redis_conf)
  end

server_concurrency = Sidekiq.options[:concurrency] + 2
Sidekiq.configure_server do |config|
  config.redis =
    ConnectionPool.new(size: server_concurrency, timeout: timeout) do
      Redis.new redis_conf.merge(namespace: 'sidekiq')
    end
end

Sidekiq.configure_client do |config|
  config.redis =
    ConnectionPool.new(size: request_thread_count, timeout: timeout) do
      Redis.new redis_conf.merge(namespace: 'sidekiq')
    end
end
