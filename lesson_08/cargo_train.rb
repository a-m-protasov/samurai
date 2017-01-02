class CargoTrain < Train

  def initialize(number)
    super(number, "cargo")
  end

  def add_car(car)
    raise "К грузовому поезду можно прицеплять только грузовые вагоны" unless car.instance_of?(CargoCar)
    super(car)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}" 
  end

end