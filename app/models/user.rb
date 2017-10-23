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

  def registered?
    roles.exists?(name: "registered")
  end

  def business_manager?
    roles.exists?(name: "business manager")
  end

  def business_admin?
    roles.exists?(name: "business admin")
  end

  def platform_admin?
    roles.exists?(name: "platform admin")
  end

  def top_level_role
    roles.pluck[:name].last
  end                        #this allows us to send to different partials based on permissions, if we want
end
