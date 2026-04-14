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
    Digest::SHA256.hexdigest(token + ENV["SALT"])
  end

  def self.secure_compare(a, b)
    ActiveSupport::SecurityUtils.secure_compare(a, b)
  end
end
