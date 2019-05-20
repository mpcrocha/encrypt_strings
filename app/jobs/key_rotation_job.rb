class KeyRotationJob < ApplicationJob
  queue_as :key_rotation

  def perform(*args)
    sleep(60.seconds)
    new_key = new_primary_key(generate_new_encrypting_key)
    EncryptedString.all.each do |enc_string|
      value = enc_string.value
      enc_string.encrypted_value = nil
      enc_string.encryption_key(new_key)
      enc_string.encrypted_value = nil
      enc_string.encrypted_value_iv = nil
      enc_string.encrypted_value_salt = nil
      enc_string.value = nil
      enc_string.value = value
      enc_string.save
    end
    remove_old_keys
  rescue StandardError => e
    Rails.logger.error("Error in key rotation #{ e.message }")
    Rails.logger.error("Error in key rotation #{ e.backtrace }")
  end

  private
  def generate_new_encrypting_key
    SecureRandom.base64(32).first(32).to_s
  end

  def new_primary_key(key)
    DataEncryptingKey.update_all(primary: false)
    dek = DataEncryptingKey.new(key: key)
    dek.primary = true
    dek.save
    dek
  end

  def remove_old_keys
    DataEncryptingKey.where.not(primary: true).delete_all
  end
end
