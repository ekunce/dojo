require 'spec_helper.rb'

describe "Cell in a Game of life" do
	context "Cell" do
		subject { Cell.new }

		describe "#new" do
			it "returns a new Cell object" do
				subject.should be_an_instance_of Cell
			end
		end

		describe "instance" do
			it "responds to proper methods" do
				subject.should respond_to :alive
				subject.should respond_to :row
				subject.should respond_to :col
				subject.should respond_to :alive?
				subject.should respond_to :dead?
				subject.should respond_to :live!
			end

			it "members are properly initialized" do
				subject.row.should eql 0
				subject.col.should eql 0
			end

			it "is initialized as dead cell" do
				subject.alive.should be_false
			end
		end

		describe "method" do
			it "live! changes the cell alive state to true" do
				cell = Cell.new
				expect {cell.live!}.to change{cell.alive}.to(true)
			end

			it "die! changes the cell alive state to false" do
				cell = Cell.new
				cell.live!
				expect {cell.die!}.to change{cell.alive}.to(false)
			end

			it "alive? should return true for alive cells" do
				cell = Cell.new
				cell.live!
				cell.should be_alive
			end

			it "dead? should return false for alive cells" do
				cell = Cell.new
				cell.live!
				cell.should_not be_dead
			end
		end
	end
end