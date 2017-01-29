class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    stations.insert(-2, station)
    puts "К маршруту #{name} добавлена станция #{station.name}"
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      raise 'Первую и последнюю станции маршрута удалять нельзя!'
    end
    stations.delete(station)
    puts "Из маршрута #{name} удалена станция #{station.name}"
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def show_stations
    puts "В маршрут #{name} входят станции: "
    stations.each { |station| puts " #{station.name}" }
  end

  def name
    stations.first.name + ' - ' + stations.last.name
  end
end
