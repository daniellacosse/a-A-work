class Link < ActiveRecord::Base
  validates :title, :url, :poster_id, presence: true

  belongs_to(
    :poster,
    class_name: "User",
    foreign_key: :poster_id,
    primary_key: :id,
    inverse_of: :link
  )

  has_many(
    :link_subs,
    class_name: "LinkSub",
    foreign_key: :link_id,
    primary_key: :id,
    inverse_of: :link
  )

  has_many :subs, through: :link_subs, source: :sub

end
