class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_stores
  has_many :stores, through: :user_stores

  validates :username, uniqueness: true, presence: true
  validates :password, presence: :true, on: :create
  validates :address, presence: :true
  validates :full_name, presence: :true
  after_save :default_user_role_to_registered

  enum role: %w(default admin)

  def self.most_active_customer
    joins(orders: [:orders_items])
    .merge(Order.completed)
    .group('users.id')
    .order('sum_orders_items_unit_price DESC')
    .sum('orders_items.unit_price')
  end

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

  def top_level_role         #not being used, but could implement if we want to break out more partials for admins
    roles.pluck[:name].last
  end

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

  private

    def default_user_role_to_registered
      role = Role.find_by(name: "registered")
      self.user_roles.create(role_id: role.id)
    end
<<<<<<< HEAD

=======
>>>>>>> a9fcccf8b0a7ccf5e532f99434d3063286a4d912
end
