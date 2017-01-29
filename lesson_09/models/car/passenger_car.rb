class PassengerCar < Car
  attr_reader :filled

  def initialize(seats_count)
    @seats_count = seats_count
    @filled = 0
  end

  def take_a_seat
    raise 'Нет свободных мест' if @filled == @seats_count
    @filled += 1
  end

  def free
    @seats_count - @filled
  end
end
