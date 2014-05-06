class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :contact_id, uniqueness: {scope: :user_id}

  belongs_to :contact, dependent: :destroy
  belongs_to :user, dependent: :destroy
end