# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{REDIS_HOST}/5" }
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{REDIS_HOST}/5" }
end
