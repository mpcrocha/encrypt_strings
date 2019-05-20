# frozen_string_literal: true

REDIS_CONFIG = Rails.application.config_for(:redis)
REDIS_HOST = "#{REDIS_CONFIG['url']}:#{REDIS_CONFIG['port']}"
