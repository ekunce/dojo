class PrimeFactors
	def self.generate(number)
		return [] if number == 1

		factor = (2..number).find { |x| number % x == 0 }
		[factor] + generate(number / factor)
	end

	def self.generate_tail(number, factors=[])
		return factors if number == 1

		new_factor = (2..number).find { |x| number % x == 0 }
		generate_tail(number / new_factor, factors + [new_factor])
	end
end