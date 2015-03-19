class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :user_id, uniqueness: true
end
