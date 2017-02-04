module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(*args)
      args ||= []
      self.checks ||= []
      self.checks << args
    end
  end

  module InstanceMethods
    def validate!
      self.class.checks.each { |val| self.send val[1].to_sym, instance_variable_get("@#{val[0]}".to_sym), val[2] }
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(value, _options)
      raise 'Значение не может быть пустым' if value.empty?
    end

    def format(value, options)
      raise 'Неверный формат' if value !~ options
    end

    def type(value, options)
      raise 'Несоответствие класса' if value.class == options
    end
  end
end