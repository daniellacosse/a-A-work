class User < ActiveRecord::Base

  attr_reader :password, :password_conf

  before_validation :reset_session_token!

  validates :email,
    :password_digest,
    :session_token,
    presence: true

  validates :email,
    :session_token,
    uniqueness: true

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email, naked_pwrd)
    found_user = User.where(email: email).first
    return if found_user.nil?
    return found_user if found_user.is_password?(naked_pwrd)
  end

  def reset_session_token!
    self.update_attribute(:session_token, User.generate_session_token)
  end

  def password=(naked_pwrd)
    self.password_digest = BCrypt::Password.create(naked_pwrd)
  end

  def is_password?(naked_pwrd)
    BCrypt::Password.new(self.password_digest) == naked_pwrd
  end
end
