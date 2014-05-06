class User < ActiveRecord::Base
  include Commentable

  attr_reader :password
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true
  before_validation :ensure_session_token

  has_many :goals


  def User.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def User.find_by_credentials(username, secret)
    @user = User.find_by_username(username)
    @user && @user.is_password?(secret) ? @user : nil
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end