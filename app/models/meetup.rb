class Meetup < ActiveRecord::Base
  has_many :users
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
