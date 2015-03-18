class User < ActiveRecord::Base
  has_many :memberships
  has_many :meetups, through: :memberships


  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid
    # referencing database, establishes provider as (arg).provider
    # establishes unique id as (arg)unique id
    validates :auth.uid
    find_by(provider: provider, uid: uid) || create_from_omniauth(auth)
    # find userby provider id and unique id or create new
  end

  def self.create_from_omniauth(auth)
    create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      username: auth.info.nickname,
      avatar_url: auth.info.image
    )
  end
end
