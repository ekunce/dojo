require_relative 'world.rb'

class Game
	attr_reader :world, :alive_cells
	def initialize(world=World.new, alive_cells=Array.new)
		@world = world
		@alive_cells = alive_cells

		alive_cells.each do |cell|
			world.cell_grid[cell[0]][cell[1]].live!
		end
	end

	def tick!
		# array of arrays - [[index, alive], [index, alive]]
		change_set = []

		# All rules need to be applied to the next generation
		@world.all_cells.each_with_index do |cell, index|

			#  rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.
			if cell.alive? && @world.get_alive_cell_neighbours(cell).count < 2
				change_set << [index, false]
			end

			#  rule 2: Any live cell with two or three live neighbours lives on to the next generation
			#    no change

			#  rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding
			if cell.alive? && @world.get_alive_cell_neighbours(cell).count > 3
				change_set << [index, false]
			end

			#  rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
			if cell.dead? && @world.get_alive_cell_neighbours(cell).count == 3
				change_set << [index, true]
			end
		end



		# apply the change set to the world
		@world.apply_change_set(change_set)
	end
end