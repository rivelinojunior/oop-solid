module BankAccount
	class Transaction
		attr_reader :type, :amount, :balance, :recorded_at

		def initialize(type:, amount:, balance:)
			@type = type
			@amount = amount
			@balance = balance
			@recorded_at = Time.now
		end
	end
end
