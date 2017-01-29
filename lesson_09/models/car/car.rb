# Test
class Car
  include Manufacturer
  include InstanceCounter
  def initialize
    register_instance
  end
end
