class CargoCar < Car

  attr_reader :filled
  
  def initialize(volume)
    @volume = volume
    @filled = 0
  end
  def load(volume)
    raise "Столько уже не влезет" if volume + @filled > @volume
    @filled += volume
  end
  def free
    @volume - @filled
  end
end