class Store < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :items
  has_many :orders
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  enum status: %w(pending approved declined)

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

end
