class Store < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :items
  has_many :orders
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  enum status: %w(Pending Online Offline Declined)

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def self.put_store_online(store)
    store.update(status: 'Online')
  end

  def self.take_store_offline(store)
    store.update(status: 'Offline')
  end

  def self.decline_store(store)
    store.update(status: 'Declined')
  end

  def self.top_selling_stores
    joins(orders: [:orders_items])
    .group('stores.id')
    .order('sum_unit_price DESC')
    .sum(:unit_price)
  end
end
