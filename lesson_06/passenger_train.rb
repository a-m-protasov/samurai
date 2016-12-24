class PassengerTrain < Train
  
  def initialize(number, type = "passenger")
    super
  end

  def add_car(car)
    raise "К пассажирскому поезду можно прицеплять только пассажирские вагоны" unless car.instance_of?(PassengerCar)
    super(car)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}" 
  end

end