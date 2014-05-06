class Track < ActiveRecord::Base
  validates :title, :lyrics, :album_id, presence: true

  belongs_to :album, dependent: :destroy
end
