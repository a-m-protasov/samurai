require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'modules/manufacturer'
require_relative 'models/station'
require_relative 'models/route'
require_relative 'models/train/train'
require_relative 'models/car/car'
require_relative 'models/train/cargo_train'
require_relative 'models/car/cargo_car'
require_relative 'models/train/passenger_train'
require_relative 'models/car/passenger_car'

CAR_TYPES = { 'cargo' => CargoCar, 'passenger' => PassengerCar }.freeze

def create_station
  puts 'C каким названием?'
  name = gets.chomp
  Station.new(name)
  puts "Построена станция #{name}"
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def create_train
  puts 'C каким номером?'
  number = gets.chomp
  raise "Поезд № #{number} уже существует" unless Train.find(number).nil?

  puts '1 - пассажирский, 2 - грузовой'
  choice = gets.chomp.to_i
  raise 'Поезд не создан. Надо было ввести 1 или 2' unless [1, 2].include?(choice)

  case choice
  when 1
    PassengerTrain.new(number)
    puts "Создан пассажирский поезд №#{number}"
  when 2
    CargoTrain.new(number)
    puts "Создан грузовой поезд №#{number}"
  end
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def add_car
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  puts 'К какому? (введите номер)'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  if train.type == 'cargo'
    puts 'Введите объем вагона'
    size = gets.chomp.to_f
  elsif train.type == 'passenger'
    puts 'Введите количество мест в вагоне'
    size = gets.chomp.to_i
  end
  train.add_car(CAR_TYPES[train.type].new(size))
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry unless Train.all.empty?
end

def remove_car
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  puts 'От какого? (введите номер)'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  raise 'У этого поезда и так нет вагонов' if train.cars.empty?
  train.remove_car(train.cars.last)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def train_to_station
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  raise 'Сначала необходимо создать станцию' if Station.all.empty?
  puts 'Какой поезд? (введите номер)'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  puts 'На какую станцию? (название)'
  name = gets.chomp
  station = Station.all.detect { |stn| stn.name == name }
  raise 'Такой станции нет' if station.nil?
  station.get_train(train)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def stations_list
  raise 'Станций еще не создано' if Station.instances.nil?
  puts 'Список станций:'
  Station.all.each { |stn| puts stn.name }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def trains_list
  raise 'Сначала необходимо создать станцию' if Station.all.empty?
  puts 'На какой? (название)'
  name = gets.chomp
  station = Station.all.detect { |station| station.name == name }
  raise 'Такой станции нет' if station.nil?
  station.iterate_trains { |train| puts "№#{train.number} #{train.type} вагонов #{train.cars.count}" }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def cars_list
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  car_number = 0
  train.iterate_cars { |car| puts "№#{car_number += 1} #{train.type} свободно #{car.free}, занято #{car.filled}" }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def load_car
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  puts 'Введите номер вагона'
  car_number = gets.chomp.to_i
  raise 'Такого вагона в поезде нет' if car_number > train.cars.size
  if train.type == 'cargo'
    puts 'Введите объем груза'
    train.cars[car_number - 1].load(gets.chomp.to_f)
  elsif train.type == 'passenger'
    train.cars[car_number - 1].take_a_seat
  end
  puts 'Сделано'
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

puts %(
0. Выход
1. Создать станцию
2. Создать поезд
3. Прицепить вагон к поезду
4. Отцепить вагон от поезда
5. Поместить поезд на станцию
6. Просмотреть список станций
7. Просмотреть список поездов на станции
8. Просмотреть список вагонов у поезда
9. Занять место/объем в вагоне
  )
loop do
  print 'Введите номер команды: '
  choice = gets.chomp.to_i

  case choice
  when 0
    puts 'До новых встреч!'
    break
  when 1
    create_station
  when 2
    create_train
  when 3
    add_car
  when 4
    remove_car
  when 5
    train_to_station
  when 6
    stations_list
  when 7
    trains_list
  when 8
    cars_list
  when 9
    load_car
  else
    puts 'Необходимо выбрать один из предложенных вариантов'
  end
end
