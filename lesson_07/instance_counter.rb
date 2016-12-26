module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :instances
    private 
    def register_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.send(:register_instance)
    end
  end

end
