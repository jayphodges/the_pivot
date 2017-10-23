class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :stores, through: :user_roles

  validates :username, uniqueness: true, presence: true
  validates :password, presence: :true
  validates :address, presence: :true
  validates :full_name, presence: :true

  enum role: %w(default admin)

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.username           = auth_info.extra.raw_info.screen_name
      new_user.password           = auth_info.credentials.token
      new_user.full_name          = auth_info.extra.raw_info.name
      new_user.address            = auth_info.extra.raw_info.location
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end
