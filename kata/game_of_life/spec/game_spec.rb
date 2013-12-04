require 'spec_helper.rb'

describe "Game in the Game Of Life" do
	let!(:world) { World.new }
	context "Game" do
		subject { Game.new }
		it "creates new Game object" do
			subject.should be_instance_of Game
		end

		it "returns initialization objects" do
			subject.should respond_to(:world)
			subject.should respond_to(:alive_cells)
		end

		it "initializes properly" do
			subject.world.should be_instance_of World
			subject.alive_cells.should be_instance_of Array
		end

		it "initializes the cell states properly" do
			game = Game.new(world, [[1, 2], [0, 2]])
			world.cell_grid[1][2].should be_alive
			world.cell_grid[0][2].should be_alive
		end
	end
end