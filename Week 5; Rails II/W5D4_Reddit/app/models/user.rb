class User < ActiveRecord::Base

  attr_reader :password

  before_validation :ensure_session_token

  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :mod_id,
    primary_key: :id
  )

  has_many(
    :posts,
    class_name: "Link",
    foreign_key: :poster_id,
    primary_key: :id
  )

  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def password=(naked_password)
    @password = naked_password
    self.password_digest = BCrypt::Password.create(naked_password)
  end

  def is_password?(naked_password)
    BCrypt::Password.new(self.password_digest) == naked_password
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user.try(:is_password?, password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end
end
