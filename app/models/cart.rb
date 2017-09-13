class Cart
  attr_reader :contents


  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

end
