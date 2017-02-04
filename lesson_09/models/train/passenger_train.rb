class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER
  def initialize(number)
    super(number, 'passenger')
  end

  def add_car(car)
    unless car.instance_of?(PassengerCar)
      raise 'К пассажирскому поезду можно прицеплять только пассажирские вагоны'
    end
    super(car)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
