require_relative 'initialize'

module BankAccountApp
  PIN = ENV.fetch('PIN', '123456')

  def self.run
    print "Pin: "
    pin = gets.strip

    user = Authentication::User.new(PIN)
    bank_account = BankAccount::BankAccount.new(user: user)

    BankAccount::Deposit.new(bank_account, 100, pin).call
    BankAccount::Deposit.new(bank_account, 100, pin).call
    BankAccount::Deposit.new(bank_account, 100, pin).call

    Presentation::Display.balance(pin, bank_account)
    Presentation::Display.statement(pin, bank_account)
    
    BankAccount::Withdraw.new(bank_account, 100, pin).call
    BankAccount::Withdraw.new(bank_account, 100, pin).call

    Presentation::Display.balance(pin, bank_account)
    Presentation::Display.statement(pin, bank_account)
    
    BankAccount::Withdraw.new(bank_account, 100, pin).call

    Presentation::Display.balance(pin, bank_account)
    Presentation::Display.statement(pin, bank_account)
  rescue BankAccount::InsufficientFundsError, Authentication::InvalidPinError => e
    Presentation::Display.message(e.message)
  end
end


BankAccountApp.run