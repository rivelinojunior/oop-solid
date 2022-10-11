module BankAccount
	class BankAccount
		attr_reader :balance, :overdraft_limit, :user, :transactions

		def initialize(user:)
			@balance = 0
			@overdraft_limit = 100
			@transactions = []
			@user = user
		end

		def deposit(amount)
			@balance += amount
		end

		def withdraw(amount)
			@balance -= amount
		end

		def record_transaction(transaction)
			@transactions << transaction
		end
	end
end
