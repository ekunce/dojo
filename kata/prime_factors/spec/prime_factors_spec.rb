require_relative "../prime_factors"

describe PrimeFactors do
	subject { PrimeFactors }
	
	it "should have generate method" do
		subject.should respond_to(:generate)	  	
	end  

	it "should have generate_tail method" do
		subject.should respond_to(:generate_tail)	  	
	end  

	it "should return empty array for 1" do
		subject.generate(1).should eql []
	end

	it "should find prime factors for 2" do
		subject.generate(2).should eql [2]
	end

	it "should find prime factors for 3" do
		subject.generate(3).should eql [3]
	end

	it "should find prime factors for 4" do
		subject.generate(4).should eql [2,2]
	end

	it "should find prime factors for 9" do
		subject.generate(9).should eql [3,3]
	end

	it "should return empty array for 1 using tail" do
		subject.generate_tail(1).should eql []
	end

	it "should find prime factors for 2 using tail" do
		subject.generate_tail(2).should eql [2]
	end

	it "should find prime factors for 3 using tail" do
		subject.generate_tail(3).should eql [3]
	end

	it "should find prime factors for 4 using tail" do
		subject.generate_tail(4).should eql [2,2]
	end

	it "should find prime factors for 9 using tail" do
		subject.generate_tail(9).should eql [3,3]
	end


end