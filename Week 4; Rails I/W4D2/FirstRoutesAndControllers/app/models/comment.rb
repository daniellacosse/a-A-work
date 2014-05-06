class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :commenter_id, presence: true

  belongs_to(
    :commenter,
    class_name: "User",
    foreign_key: :commenter_id,
    primary_key: :id
  )

  belongs_to :commentable, polymorphic: true
end