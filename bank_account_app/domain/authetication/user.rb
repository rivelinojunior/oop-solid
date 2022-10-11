module Authentication
  class User
    attr_reader :pin

    def initialize(pin)
      @pin = pin
    end
  end
end
