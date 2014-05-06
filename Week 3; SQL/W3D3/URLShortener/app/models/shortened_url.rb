class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :user, :uniq => true

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    until ShortenedUrl.unique_url?(random_code)
      random_code = SecureRandom.urlsafe_base64
    end
    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)

    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )

  end

  def num_clicks
    Visit.where(shortened_url_id: self.id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    Visit.where(shortened_url_id: self.id, :created_at => (10.minutes.ago..Time.now)).count
  end

  private
  def self.unique_url?(url)
    !ShortenedUrl.exists?(short_url: url)
  end
end