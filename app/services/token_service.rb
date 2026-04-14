class TokenService
  def self.generate_for(student)
    raw_token = SecureRandom.urlsafe_base64(32)
    student.token_digest = digest(raw_token)

    raw_token
  end

  def self.valid?(token_digest, raw_token)
    return false if raw_token.blank?

    secure_compare(token_digest, digest(raw_token))
  end

  def self.digest(token)
    secret = Rails.application.credentials.secret_key_base
    Digest::SHA256.hexdigest(token + secret)
  end

  def self.secure_compare(a, b)
    ActiveSupport::SecurityUtils.secure_compare(a, b)
  end
end
