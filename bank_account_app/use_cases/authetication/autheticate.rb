module Authentication
  class Authenticate
    def initialize(user, pin)
      @user = user
      @pin = pin
    end

    def call
      return true if user.pin.eql?(pin)

      raise Authentication::InvalidPinError, 'Access denied: invalid PIN!'
    end

    private

    attr_reader :user, :pin
  end
end