class Train

  include Manufacturer
  include InstanceCounter

  attr_accessor :speed, :number, :cars, :route, :station
  attr_reader :type
  @@trains = {}


  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    if speed.zero? 
      self.cars << car
      puts "К поезду №#{number} прицепили вагон."
    else 
      puts "На ходу нельзя прицеплять вагоны!"
    end
  end

  def remove_car(car)
    if !cars.include?(car)
      puts "Такого вагона в этом поезде нет"
    elsif speed.zero? 
      self.cars.delete(car)
      puts "От поезда №#{number} отцепили вагон."
    else 
      puts "На ходу нельзя отцеплять вагоны!"
    end
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}" 
  end

  def go_to(station)
    if route.nil?
      puts "Без маршрута поезд заблудится."
    elsif @station == station
      puts "Поезд №#{@number} и так на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "Станция #{station.name} не входит в маршрут поезда №#{number}"
    end
  end

  def stations_around
    if route.nil?
      puts "Маршрут не задан"
    else
      station_index = route.stations.index(station)
      puts "Сейчас поезд на станции #{station.name}."
      puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Следующая - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end
end