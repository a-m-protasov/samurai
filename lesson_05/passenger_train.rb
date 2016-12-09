class PassengerTrain < Train
  
  def initialize(number, type = "passenger")
    super
  end

  def add_car(car)
    if car.instance_of?(PassengerCar)
      super(car)
    else
      puts "К пассажирскому поезду можно прицеплять только пассажирские вагоны"
    end 
  end

end