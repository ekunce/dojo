require 'spec_helper.rb'

describe "Game Of Life" do

	let!(:world) { World.new }
	context 'Rules' do 
		# let!(:game){ Game.new }

		context '1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
			it 'Kills a live cell with exactly one alive neighbour' do
				game = Game.new(world, [[1, 0], [2, 0]])
				game.tick!

				game.world.cell_grid[1][0].should be_dead
				game.world.cell_grid[2][0].should be_dead
			end	

			it 'Kills a live cell with zero alive neighbours' do
				game = Game.new(world, [[1, 1]])
				game.tick!

				game.world.cell_grid[1][1].should be_dead
			end
		end

		context '2. Any live cell with two or three live neighbours lives on to the next generation.' do
			it "Leaves a cell with two alive neighbours" do
				game = Game.new(world, [[1, 1], [0, 1], [2, 1]])
				game.tick!

				game.world.cell_grid[1][1].should be_alive
			end

			it "Leaves a cell with three alive neighbours" do
				game = Game.new(world, [[1, 1], [0, 1], [2, 1], [1, 2]])
				game.tick!

				game.world.cell_grid[1][1].should be_alive
			end
		end

		context '3. Any live cell with more than three live neighbours dies, as if by overcrowding.' do
			it "Kills a cell with four live neighbours" do
				game = Game.new(world, [[1, 1], [0, 1], [2, 1], [1, 2], [1, 0]])
				game.tick!

				game.world.cell_grid[1][1].should be_dead
			end
		end

		context '4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
			it "Makes a cell with three live neighbours alive" do
				game = Game.new(world, [[0, 1], [2, 1], [1, 2]])
				game.tick!

				game.world.cell_grid[1][1].should be_alive
			end
		end

		context 'All rules together' do
			it "Runs a simple oscilator check" do
				game = Game.new(world, [[0, 1], [1, 1], [2, 1]])

				# [. * .]
				# [. * .]
				# [. * .]

				game.tick!

				# [. . .]
				# [* * *]
				# [. . .]

				game.world.cell_grid[1][0].should be_alive
				game.world.cell_grid[1][1].should be_alive
				game.world.cell_grid[1][2].should be_alive

				game.world.cell_grid[0][0].should be_dead
				game.world.cell_grid[0][1].should be_dead
				game.world.cell_grid[0][2].should be_dead

				game.world.cell_grid[2][0].should be_dead
				game.world.cell_grid[2][1].should be_dead
				game.world.cell_grid[2][2].should be_dead

				game.tick!

				# [. * .]
				# [. * .]
				# [. * .]

				game.world.cell_grid[0][0].should be_dead
				game.world.cell_grid[0][1].should be_alive
				game.world.cell_grid[0][2].should be_dead

				game.world.cell_grid[1][0].should be_dead
				game.world.cell_grid[1][1].should be_alive
				game.world.cell_grid[1][2].should be_dead


				game.world.cell_grid[2][0].should be_dead
				game.world.cell_grid[2][1].should be_alive
				game.world.cell_grid[2][2].should be_dead

			end
		end
	end
end