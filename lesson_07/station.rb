class Station
  include InstanceCounter
  include Valid
  @@stations = []
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end
    
  def get_train(train)
    raise "Поезд #{train.number} и так на станции #{name}" if @trains.include?(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  def iterate_trains(&block)
    raise "На станции нет поездов" if @trains.empty?
    @trains.each{|train| block.call(train)}
  end

protected
  def validate!
    raise "Название станции не может быть пустым, попробуйте еще раз." if name.empty?
  end

end