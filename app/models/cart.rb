class Cart
  attr_reader :contents


  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end
end
