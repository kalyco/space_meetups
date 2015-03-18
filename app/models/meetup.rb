class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :members
  
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
