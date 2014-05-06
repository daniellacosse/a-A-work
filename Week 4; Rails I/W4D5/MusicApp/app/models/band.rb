class Band < ActiveRecord::Base
  validates :band_name, presence: true

  has_many :albums
  has_many :tracks, through: :albums
end
