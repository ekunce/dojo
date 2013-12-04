require_relative 'cell'
require_relative 'rle'

class World
	attr_reader :rows, :cols, :all_cells
	attr_accessor :cell_grid

	def initialize rows = 3, cols = 3
		@rows = rows
		@cols = cols
		@all_cells = []

		@cell_grid = Array.new(rows) do |row|
			Array.new(cols) do |col|
				cell = Cell.new row, col
				all_cells << cell
				cell
			end
		end
	end

	def get_alive_cell_neighbours(cell)
		alive_neighbours = []
		
		# North sector
		if cell.row > 0
			# North
			test_cell = @cell_grid[cell.row-1][cell.col]
			alive_neighbours << test_cell if test_cell.alive?

			# North-West
			if cell.col > 0
				test_cell = @cell_grid[cell.row-1][cell.col-1]
				alive_neighbours << test_cell if test_cell.alive?
			end

			# North-East
			if cell.col < @cols-1
				test_cell = @cell_grid[cell.row-1][cell.col+1]
				alive_neighbours << test_cell if test_cell.alive?
			end
		end

		# West
		if cell.col > 0
			test_cell = @cell_grid[cell.row][cell.col-1]
			alive_neighbours << test_cell if test_cell.alive?
		end

		# East
		if cell.col < @cols-1
			test_cell = @cell_grid[cell.row][cell.col+1]
			alive_neighbours << test_cell if test_cell.alive?
		end
		

		# South sector
		if cell.row < @rows-1
			# South
			test_cell = @cell_grid[cell.row+1][cell.col]
			alive_neighbours << test_cell if test_cell.alive?

			# South West
			if cell.col > 0
				test_cell = @cell_grid[cell.row+1][cell.col-1]
				alive_neighbours << test_cell if test_cell.alive?
			end

			# South East
			if cell.col < @cols-1
				test_cell = @cell_grid[cell.row+1][cell.col+1]
				alive_neighbours << test_cell if test_cell.alive?
			end

		end
		
		alive_neighbours
	end

	def apply_change_set(change_set)
		change_set.each do |set|
			if set[1]
				@all_cells[set[0]].live!
			else
				@all_cells[set[0]].die!
			end
		end
	end

	def get_live_cells
		all_cells.select { |cell| cell.alive? }
	end

	def generate_random_live_cells
		all_cells.each do |cell|
			if [true, false].sample
				cell.live!
			end
		end
	end

	def generate_from_rle(rle, row_offset = 0, col_offset = 0)

		# check offset for negative values
		if row_offset < 0 || col_offset < 0
			return false
		end

		# check offset for too big values
		if row_offset > @rows || col_offset > @cols
			return false
		end

		# check, if the pattern fits into the field
		if (row_offset + rle.rows) > @rows || (col_offset + rle.cols) > @cols
			return false
		end
		

		rle.cell_array.each_with_index do |one_row, row_index|
			one_row.each_with_index do |cell_value, col_index|
				if cell_value == 1
					@cell_grid[row_offset + row_index][col_offset + col_index].live!
				end
			end
		end

		return true
	end
end
