class Album < ActiveRecord::Base
  validates :title, :recording, :band_id, presence: true

  validates :recording, inclusion: { in: %w{live studio}, message: "%{value} is not a valid choice" }

  belongs_to :band, dependent: :destroy
  has_many :tracks
end
