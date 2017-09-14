class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def update_item(id, quantity)
    contents[id.to_s] = quantity.to_i
  end

  def subtotal(item)
    id = item.id
    quantity = contents[id.to_s]
    num = quantity * item.price
    sprintf('%.2f', num)
  end

  def total
    mapped_cont = contents.map do |content|
      item = Item.find_by(id: content.first)
      item.price * content.last
    end
    total = mapped_cont.sum
    sprintf('%.2f', total)
  end

  def quantity(item)
    id = item.id
    contents[id.to_s]
  end

end
