module Manufacturer
  attr_accessor :manufacturer
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :counter  
    def instances
      self.counter
    end

  end

  module InstanceMethods
    protected
    attr_accessor :counter  
    def register_instance
      self.class.counter = 0 if self.class.counter == nil
      self.class.counter += 1
    end
  end
end
