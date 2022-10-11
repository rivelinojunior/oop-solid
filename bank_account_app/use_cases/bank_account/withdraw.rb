module BankAccount
  class Withdraw
    def initialize(bank_account, amount, pin, klass: {})
      @bank_account = bank_account
      @amount = amount
      @pin = pin
      @authenticator = klass.fetch(:authenticator, Authentication::Authenticate)
    end

    def call
      authenticate!
      raise_insufficient_funds unless balance_available?

      bank_account.withdraw(amount)
      transaction = Transaction.new(type: 'debit', amount: amount, balance: bank_account.balance)
      bank_account.record_transaction(transaction)

      bank_account
    end

    private 

    attr_reader :bank_account, :amount, :pin, :authenticator

    def balance_available?
      (bank_account.balance + bank_account.overdraft_limit) >= amount
    end

    def raise_insufficient_funds
      raise InsufficientFundsError, 'Insufficient funds!'
    end

    def authenticate!
      authenticator.new(bank_account.user, pin).call
    end
  end
end
