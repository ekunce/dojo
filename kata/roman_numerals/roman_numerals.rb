class RomanConverter
	
	ROMAN_CHAR_VALUES_HASH = {
		'I' => 1,
		'V' => 5,
		'X' => 10,
		'L' => 50,
		'C' => 100,
		'D' => 500,
		'M' => 1000
	}

	def self.to_roman(num_to_convert)
		thousands = num_to_convert / 1000
		hundreds = num_to_convert / 100 % 10
		tens  = num_to_convert / 10 % 10
		ones = num_to_convert % 10

		r_thousands = "M" * thousands
		r_hundreds = self.roman_numeral_for(hundreds, "C", "D", "M")
		r_tens = self.roman_numeral_for(tens, "X", "L", "C")
		r_ones = self.roman_numeral_for(ones, "I", "V", "X")

		r_thousands + r_hundreds + r_tens + r_ones
	end

	def self.from_roman(roman_numeral)
		roman_arr = roman_numeral.chars.to_a

		case
			when roman_arr.empty?
				0
			when roman_arr.size == 1
				ROMAN_CHAR_VALUES_HASH[roman_arr.shift]
			when ROMAN_CHAR_VALUES_HASH[roman_arr[0]] < ROMAN_CHAR_VALUES_HASH[roman_arr[1]]
				-ROMAN_CHAR_VALUES_HASH[roman_arr.shift] + self.from_roman(roman_arr.join)
			else
				ROMAN_CHAR_VALUES_HASH[roman_arr.shift] + self.from_roman(roman_arr.join)
		end
	end

	def self.roman_numeral_for(value, one_of_a_kind, five_of_a_kind, ten_of_a_kind)
		case value
			when 0
				''
			when 1..3
				one_of_a_kind * value
			when 4
				one_of_a_kind + five_of_a_kind
			when 5
				five_of_a_kind
			when 6..8
				five_of_a_kind + one_of_a_kind * (value - 5)
			when 9
				one_of_a_kind + ten_of_a_kind
		end
	end
end