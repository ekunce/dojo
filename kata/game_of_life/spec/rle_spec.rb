require 'spec_helper.rb'

$glider = "bo$2bo$3o!"
$glider_rows = 3
$glider_cols = 3

# GLIDER
# [[0,1,0]
# [0,0,1]
# [1,1,1]]

describe Rle do

	subject { Rle.new }

	it "#new creates a new instance" do
		subject.should be_an_instance_of Rle
	end

	it "responds to member methods" do
		subject.should respond_to(:rows)
		subject.should respond_to(:cols)
		subject.should respond_to(:match_pattern)
		subject.should respond_to(:cell_array)
		subject.should respond_to(:decode_file)
		subject.should respond_to(:decode_string)
		subject.should respond_to(:pattern_name)
		subject.should respond_to(:pattern_comments)
	end

	context "decodes" do
		it "single row string properly" do
			subject.decode_string($glider, $glider_rows, $glider_cols)

			subject.cell_array.should_not be_empty
			subject.cell_array.length.should eql $glider_rows

			subject.cell_array.each do |single_line|
				single_line.length.should eql $glider_cols
			end

			subject.rows.should eql $glider_rows
			subject.cols.should eql $glider_cols
		end

		it "decodes glider properly from string" do
			subject.decode_string($glider, $glider_rows, $glider_cols)

			subject.cell_array[0][0].should eql 0
			subject.cell_array[0][1].should eql 1
			subject.cell_array[0][2].should eql 0

			subject.cell_array[1][0].should eql 0
			subject.cell_array[1][1].should eql 0
			subject.cell_array[1][2].should eql 1

			subject.cell_array[2][0].should eql 1
			subject.cell_array[2][1].should eql 1
			subject.cell_array[2][2].should eql 1
		end

		it "rle file properly" do
			subject.decode_file('patterns/glider.rle').should be_true
			subject.pattern_name.should eql "Glider"

			subject.cell_array[0][0].should eql 0
			subject.cell_array[0][1].should eql 1
			subject.cell_array[0][2].should eql 0

			subject.cell_array[1][0].should eql 0
			subject.cell_array[1][1].should eql 0
			subject.cell_array[1][2].should eql 1

			subject.cell_array[2][0].should eql 1
			subject.cell_array[2][1].should eql 1
			subject.cell_array[2][2].should eql 1

		end
	end
end