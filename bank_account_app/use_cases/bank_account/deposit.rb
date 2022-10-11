module BankAccount
  class Deposit
    def initialize(bank_account, amount, pin, klass: {})
      @bank_account = bank_account
      @amount = amount
      @pin = pin
      @authenticator = klass.fetch(:authenticator, Authentication::Authenticate)
    end

    def call
      authenticate!
      bank_account.deposit(amount)
      transaction = Transaction.new(type: 'credit', amount: amount, balance: bank_account.balance)
      bank_account.record_transaction(transaction)

      bank_account
    end

    private 

    attr_reader :bank_account, :amount, :pin, :authenticator

    def authenticate!
      authenticator.new(bank_account.user, pin).call
    end
  end
end
