require_relative '..\phone_numbers'

describe "Phone Number Checker" do 
	context "PhoneNumbersChecker" do
		subject { PhoneNumbersChecker }
	
		it "should have a method is_file_consistent" do 
			subject.should respond_to(:is_file_consistent)
		end

	end
end