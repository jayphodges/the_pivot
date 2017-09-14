class Item < ApplicationRecord
  belongs_to :category

  def formatted_price
    sprintf('%.2f', price)
  end
end
