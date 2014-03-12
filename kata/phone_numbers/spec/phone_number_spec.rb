require_relative '..\phone_numbers'

describe PhoneNumbersChecker do 
	subject { PhoneNumbersChecker }

	it "should have a method is_file_consistent" do 
		subject.should respond_to(:is_file_consistent)
	end

	it "should raise exception if file doesn't exist" do 
		expect { subject.is_file_consistent("wrong file name") }.to raise_error
	end

	it "should return true for consistent file and no names" do
		consistent,names = subject.is_file_consistent("phone_data_10_consistent.txt")
		consistent.should be_true
		names.should be_empty
	end

	it "should return false and the names of people for inconsistent file" do
		consistent,names = subject.is_file_consistent("phone_data_10_inconsistent.txt")
		consistent.should be_false
		names.should_not be_empty

		names[0].should eql "Kimberlee Turlington"
		names[1].should eql "Micheal Veronesi"
	end
end