class Station
  
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Построена станция #{name}"
  end

  def get_train(train)
    trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  def show_trains(type = "all")
      if type == "all"
        puts "Поезда на станции #{name}: "
        trains.each{|train| puts train.number}
      else
        puts "Поезда на станции #{name} типа #{type}: "  
        trains.each{|train| puts train.number if train.type == type}
      end
  end
end

class Route
  
  attr_accessor :stations, :from, :to
  
  def initialize (from, to)
    @from = from
    @to = to
    @stations = [from, to]
    puts "Создан маршрут #{from.name} - #{to.name}"
  end

  def add_station(station)
    self.stations.insert(-2, station) 
    puts "К маршруту #{from.name} - #{to.name} добавлена станция #{station.name}"
  end

  def remove_station(station)
    if station == stations.first || station == stations.last
      puts "Первую и последнюю станции маршрута удалять нельзя!"
    else 
      self.stations.delete(station)
      puts "Из маршрута #{from.name} - #{to.name} удалена станция #{station.name}"
    end
  end

  def show_stations
    puts "В маршрут #{from.name} - #{to.name} входят станции: "
    stations.each{|station| puts " #{station.name}" }
  end  
end

class Train

  attr_accessor :speed, :number, :car_count, :route, :station
  attr_reader :type

  def initialize(number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
    puts "Создан поезд № #{number}. Тип: #{type}. Количество вагонов: #{car_count}."
  end

  def stop
    self.speed = 0
  end

  def add_car
    if speed.zero? 
      self.car_count += 1
      puts "К поезду №#{number} прицепили вагон. Теперь их #{car_count}."
    else 
      puts "На ходу нельзя прицеплять вагоны!"
    end
  end

  def remove_car
    if car_count.zero?
      puts "Вагонов уже не осталось."
    elsif speed.zero? 
      self.car_count -= 1
      puts "От поезда №#{number} отцепили вагон. Теперь их #{car_count}."
    else 
      puts "На ходу нельзя отцеплять вагоны!"
    end
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.from.name} - #{route.to.name}" 
  end

  def go_to(station)
    if route.nil?
      puts "Без маршрута поезд заблудится."
    elsif route.stations.include?(station)
      self.station = station
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


station_kr1 = Station.new("Краснодар 1")
station_nvs = Station.new("Новороссийск")
station_sci = Station.new("Сочи")
station_gkl = Station.new("Горячий Ключ")
station_tps = Station.new("Туапсе")
station_sci = Station.new("Сочи")
station_adl = Station.new("Адлер")

route_kr1_sci = Route.new(station_kr1, station_sci)
route_kr1_sci.add_station(station_gkl)
route_kr1_sci.add_station(station_tps)
route_kr1_sci.show_stations
route_kr1_sci.remove_station(station_kr1)
route_kr1_sci.remove_station(station_sci)
route_kr1_sci.remove_station(station_gkl)
route_kr1_sci.show_stations

train1 = Train.new(1,"passenger", 12)
train2 = Train.new(2, "cargo", 20)
train3 = Train.new(3,"passenger", 14)
train4 = Train.new(4, "cargo", 22)

train1.take_route(route_kr1_sci)
train1.go_to(station_adl)
train1.go_to(station_tps)
train1.go_to(station_sci)

station_tps.get_train(train2)
station_tps.get_train(train3)
station_tps.get_train(train4)

station_tps.show_trains("cargo")
station_adl.show_trains("passenger")
train2.stations_around
train1.stations_around



