
class Goal < ActiveRecord::Base
  include Commentable

  validates :name, :description, presence: true

  belongs_to :user
end
