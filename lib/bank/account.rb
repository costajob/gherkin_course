module Bank
  class Account
    DEFAULT_CURRENCY = "USD"
    DEFAULT_PIN = "0000"
    WRONG_PIN_MAX_TRIES = 3

    class WrongPINError < ArgumentError; end
    class SamePINError < ArgumentError; end
    class BlockedPINError < ArgumentError; end
    class InsufficientBalanceError < ArgumentError; end

    attr_reader :name

    def initialize(name, amount, pin = DEFAULT_PIN, currency = DEFAULT_CURRENCY)
      @name = name
      @balance = amount.to_i
      @pin = pin
      @currency = currency
      reset_pin_tries!
    end

    def balance(pin)
      check_pin(pin)
      @balance
    end

    def deposit(amount, pin)
      check_pin(pin)
      @balance += amount.to_i
    end

    def withdraw(amount, pin)
      check_pin(pin)
      amount.to_i.tap do |a|
        fail InsufficientBalanceError, "Your balance is insufficient!" if a > @balance
        @balance -= a
      end
    end

    def change_pin(old_pin, new_pin)
      check_pin(old_pin)
      fail SamePINError if old_pin == new_pin
      @pin = new_pin
    end

    def reset_pin!(pin)
      if pin == @pin
        @pin = DEFAULT_PIN
        reset_pin_tries!
      end
    end

    private

    def check_pin(pin)
      fail BlockedPINError, "Your PIN is blocked, reset it!" if pin_blocked?

      if pin != @pin
        @wrong_pin_tries += 1
        fail WrongPINError, "Wrong PIN, please retry!"
      end
    end

    def pin_blocked?
      @wrong_pin_tries >= WRONG_PIN_MAX_TRIES
    end

    def reset_pin_tries!
      @wrong_pin_tries = 0
    end
  end
end
