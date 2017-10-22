class Store < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :items
  has_many :orders
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  enum status: %w(Pending Approved Declined)

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def self.approve_store(store)
    store.update(status: 'Approved')
  end

  def self.decline_store(store)
    store.update(status: 'Declined')
  end
end
