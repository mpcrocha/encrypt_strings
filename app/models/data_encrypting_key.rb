class DataEncryptingKey < ActiveRecord::Base

  attr_encrypted :key,
                 key: :key_encrypting_key

  validates :key, presence: true

  def self.primary
    find_by(primary: true) || DataEncryptingKey.new(key: ENV['KEY_ENCRYPTING_KEY'].to_s)
  end

  def self.generate!(attrs={})
    create!(attrs.merge(key: AES.key))
  end

  def key_encrypting_key
    ENV['KEY_ENCRYPTING_KEY'].to_s
  end
end

