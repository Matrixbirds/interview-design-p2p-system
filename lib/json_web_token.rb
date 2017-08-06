require 'jwt'
module JsonWebToken
  def self.encode(payload, exp = nil)
    exp ||= 1.day.from_now
    payload[:exp] = exp.to_i
    JWT.encode(payload, hmac_secret)
  end

  def self.decode!(token)
    JWT.decode(token, hmac_secret)[0].with_indifferent_access
  end

  def self.decode(token)
    decode!(token)
  rescue
    nil
  end

  def self.hmac_secret
    Rails.application.secrets.secret_key_base
  end
end
