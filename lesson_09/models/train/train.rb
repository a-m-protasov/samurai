class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_accessor :speed, :number, :cars, :route, :station
  attr_reader :type
  @@trains = {}
  TRAIN_NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def self.all
    @@trains
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    raise 'На ходу нельзя прицеплять вагоны!' unless speed.zero?
    cars << car
    puts "К поезду №#{number} прицепили вагон."
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def remove_car(car)
    raise 'На ходу нельзя отцеплять вагоны!' unless speed.zero?
    raise 'Такого вагона в этом поезде нет' unless cars.include?(car)
    cars.delete(car)
    puts "От поезда №#{number} отцепили вагон."
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}"
  end

  def go_to(station)
    raise 'Без маршрута поезд заблудится.' if route.nil?
    raise "Поезд №#{@number} и так на станции #{@station.name}" if @station == station
    unless route.stations.include?(station)
      raise "Станция #{station.name} не входит в маршрут поезда №#{number}"
    end
    @station.send_train(self) if @station
    @station = station
    station.get_train(self)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def stations_around
    raise 'Маршрут не задан' if route.nil?
    station_index = route.stations.index(station)
    puts "Сейчас поезд на станции #{station.name}."
    puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
    if station_index != route.stations.size - 1
      puts "Следующая - #{route.stations[station_index + 1].name}."
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def iterate_cars
    raise 'К поезду не прицеплено вагонов' if @cars.empty?
    @cars.each { |car| yield(car) }
  end
end
