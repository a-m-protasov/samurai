require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'cargo_car'
require_relative 'passenger_train'
require_relative 'passenger_car'

stations = []
trains = []

puts %Q(
Выберите пункт меню:
0. Выход
1. Создать станцию
2. Создать поезд
3. Прицепить вагон к поезду
4. Отцепить вагон от поезда
5. Поместить поезд на станцию
6. Просмотреть список станций
7. Просмотреть список поездов на станции
	)
loop do
	choice = gets.chomp.to_i
	case choice

	when 0 #Выход	
		puts "До новых встреч!"
		break

	when 1 #Создать станцию
		puts "C каким названием?"
		name = gets.chomp
		stations << Station.new(name)
		puts "Построена станция #{name}"

	when 2 #Создать поезд
		puts "C каким номером?"
		number = gets.chomp
		puts "1 - пассажирский, 2 - грузовой"
		choice = gets.chomp.to_i
		case choice
		when 1
			trains << PassengerTrain.new(number)
			puts "Создан пассажирский поезд №#{number}"
		when 2
			trains << CargoTrain.new(number)
			puts "Создан грузовой поезд №#{number}"
		else 
			puts "Поезд не создан. Надо было ввести 1 или 2"
		end

	when 3 #Прицепить вагон к поезду
		if trains.empty?
			puts "Сначала необходимо создать поезд"
		else 
			puts "К какому? (введите номер)"
			number = gets.chomp
			train = trains.select{|train| train.number == number}.first
			if train.nil?
				puts "Поезда с таким номером нет"
			elsif train.type == "cargo"
				train.add_car(CargoCar.new)
			elsif train.type == "passenger"
				train.add_car(PassengerCar.new)
			end
		end

	when 4 #Отцепить вагон от поезда
		if trains.empty?
			puts "Сначала необходимо создать поезд"
		else 
			puts "От какого? (введите номер)"
			number = gets.chomp
			train = trains.select{|train| train.number == number}.first
			if train.nil?
				puts "Поезда с таким номером нет"
			elsif train.cars.empty?
				puts "У этого поезда и так нет вагонов"
			else 
				train.remove_car(train.cars[-1])
			end
		end

	when 5 #Поместить поезд на станцию
		if trains.empty?
			puts "Сначала необходимо создать поезд"
		elsif stations.empty?
			puts "Сначала необходимо создать станцию"
		else 
			puts "Какой поезд? (введите номер)"
			number = gets.chomp
			train = trains.select{|train| train.number == number}.first
			if train.nil?
				puts "Поезда с таким номером нет"
			else 
				puts "На какую станцию? (название)"
				name = gets.chomp
				station = stations.select{|station| station.name == name}.first
				if station.nil?
					puts "Такой станции нет" 
				else 
					station.get_train(train)
				end	
			end
		end

	when 6 #Просмотреть список станций
		puts "Список станций:"
		stations.each{|station| puts station.name}

	when 7 #Просмотреть список поездов на станции
		if stations.empty?
			puts "Сначала необходимо создать станцию"
		else
			puts "На какой? (название)"
			name = gets.chomp
			station = stations.select{|station| station.name == name}.first
			if station.nil?
				puts "Такой станции нет" 
			else 
				station.show_trains
			end
		end
	else
		puts "Необходимо выбрать один из предложенных вариантов"
	end
end
