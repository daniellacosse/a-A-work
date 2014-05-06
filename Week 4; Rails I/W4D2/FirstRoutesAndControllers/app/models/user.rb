class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contacts
  has_many :contact_shares
  has_many :comments, as: :commentable
  has_many :shared_contacts, through: :contact_shares, source: :contact
  has_many(
    :made_comments,
    class_name: "Comment",
    foreign_key: :commenter_id,
    primary_key: :id
  )

  def self.favorites_by_id(id)
    favorites = Contact.where(favorite: true, user_id: id)
    favorites += ContactShare.where(favorite: true, user_id: id).map(&:contact)
    favorites
  end
end