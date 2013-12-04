require_relative '../roman_numerals'

describe 'Roman numerals converter' do

	it "implements the required methods" do
		RomanConverter.should respond_to(:to_roman)
		RomanConverter.should respond_to(:from_roman)
		RomanConverter.should respond_to(:roman_numeral_for)
	end

	it "validates the input parameters" do
		expect  { RomanConverter.to_roman(-1) }.to raise_exception
	end

	it "converts one numeral with correct literal order swap when appropriate" do
		RomanConverter.roman_numeral_for(1, "I", "V", "X").should eql "I"
		RomanConverter.roman_numeral_for(4, "I", "V", "X").should eql "IV"
		RomanConverter.roman_numeral_for(9, "I", "V", "X").should eql "IX"

		RomanConverter.roman_numeral_for(1, "X", "L", "C").should eql "X"
		RomanConverter.roman_numeral_for(4, "X", "L", "C").should eql "XL"
		RomanConverter.roman_numeral_for(9, "X", "L", "C").should eql "XC"

		RomanConverter.roman_numeral_for(1, "C", "D", "M").should eql "C"
		RomanConverter.roman_numeral_for(4, "C", "D", "M").should eql "CD"
		RomanConverter.roman_numeral_for(9, "C", "D", "M").should eql "CM"
	end

	it "converts one integer number to roman numeral" do
		RomanConverter.to_roman(0).should eql ""
		RomanConverter.to_roman(1).should eql "I"
		RomanConverter.to_roman(2).should eql "II"
		RomanConverter.to_roman(4).should eql "IV"
		RomanConverter.to_roman(9).should eql "IX"
		RomanConverter.to_roman(10).should eql "X"
		RomanConverter.to_roman(99).should eql "XCIX"
		RomanConverter.to_roman(999).should eql "CMXCIX"
		RomanConverter.to_roman(1954).should eql "MCMLIV"
		RomanConverter.to_roman(1990).should eql "MCMXC"
		RomanConverter.to_roman(2008).should eql "MMVIII"
		RomanConverter.to_roman(2013).should eql "MMXIII"
	end

	it "converts one roman numeral to integer" do
		RomanConverter.from_roman("").should eql 0
		RomanConverter.from_roman("I").should eql 1
		RomanConverter.from_roman("II").should eql 2
		RomanConverter.from_roman("IV").should eql 4
		RomanConverter.from_roman("IX").should eql 9
		RomanConverter.from_roman("X").should eql 10
		RomanConverter.from_roman("XCIX").should eql 99
		RomanConverter.from_roman("CMXCIX").should eql 999
		RomanConverter.from_roman("MCMLIV").should eql 1954
		RomanConverter.from_roman("MCMXC").should eql 1990
		RomanConverter.from_roman("MMVIII").should eql 2008
		RomanConverter.from_roman("MMXIII").should eql 2013
	end
end