class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :members

  validates :name, presence: true, on: :create
  validates :location, presence: true, on: :create
  validates :description, presence: true, on: :create
end
