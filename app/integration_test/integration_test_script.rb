require 'net/http'
require 'json'

class IntegrationTestScript
  def self.integration_test
    for i in 1..1000
      EncryptedString.new(value: i)
    end

    KeyRotationJob.perform_later

    response = ''

    url = 'http://0.0.0.0:3000/data_encrypting_keys/status'
    uri = URI(url)

    while response != 'No key rotation queued or in progress'
      response = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)[:message]
      puts 'rotation key in progress'
    end

    puts 'Finish rotation key'
  end
end
