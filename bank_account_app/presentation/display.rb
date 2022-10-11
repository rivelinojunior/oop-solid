module Presentation
  class Display
    def self.balance(pin, bank_account)
      Authentication::Authenticate.new(bank_account.user, pin).call

      puts "Balance: #{bank_account.balance}"
    end

    def self.statement(pin, bank_account)
      Authentication::Authenticate.new(bank_account.user, pin).call

      puts "-------------------------------------------- \n"

      i = 0
      rows = ''

      while i < bank_account.transactions.size
        record = bank_account.transactions[i]

        rows << (
          "#{record.recorded_at.strftime("%Y-%m-%d")} | " +
          "#{record.type} | " +
          "#{record.amount} | " +
          "#{record.balance} \n"
        )

        i += 1
      end

      puts "date       | type | amount | balance", rows
      puts "-------------------------------------------- \n\n\n\n"
    end

    def self.message(message)
      puts message
    end
  end
end
