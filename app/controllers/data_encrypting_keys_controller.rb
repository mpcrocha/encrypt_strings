class DataEncryptingKeysController < ApplicationController
  require 'sidekiq/api'

  def rotate
    queue = Sidekiq::Queue.new("key_rotation")
    workers = Sidekiq::Workers.new
    if queue.size == 0 and workers.size == 0
      KeyRotationJob.perform_later
    else
      render json: { message: 'There is a key rotation in progress', status: 422 }
    end

  end

  def status
    queue = Sidekiq::Queue.new("key_rotation")
    workers = Sidekiq::Workers.new

    message = 'No key rotation queued or in progress'
    message = 'Key rotation has been queued' if queue.size > 0
    message = 'Key rotation is in progress' if workers.size > 0

    render json: { message: message }
  end

end
