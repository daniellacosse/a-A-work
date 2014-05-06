class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: true

  belongs_to(
    :owner,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many :contact_shares
  has_many :comments, as: :commentable
  has_many :shared_users, through: :contact_shares, source: :user

  def self.contacts_for_user_id(user_id)
    Contact.joins("LEFT OUTER JOIN contact_shares AS cs ON contacts.id = cs.contact_id")
           .where("contacts.id = ? OR cs.contact_id = ?", user_id, user_id)
  end
end