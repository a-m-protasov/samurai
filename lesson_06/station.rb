class Station
  include InstanceCounter
  include Valid
  @@stations = []
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def self.all
    @@stations
  end
    
  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  def show_trains(type = nil)

      if type
        puts "Поезда на станции #{name} типа #{type}: "  
        @trains.each{|train| puts train.number if train.type == type}
      else
        raise "На станции нет поездов" if @trains.empty?
        puts "Поезда на станции #{name}: "
        @trains.each{|train| puts train.number}

      end
  end

protected
  def validate!
    raise "Название станции не может быть пустым, попробуйте еще раз." if name.empty?
  end

end