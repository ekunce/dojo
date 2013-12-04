require 'spec_helper.rb'

$rows = 3
$cols = 3

describe "World in a Game of life" do
	context "World" do

		let!(:cell){ Cell.new(1,1) }

		subject { World.new $rows, $cols }

		describe "#new" do
			it "returns a new world object" do
				subject.should be_an_instance_of Cell
			end
		end

		describe "dimensions" do

			it "responds to member methods" do
				subject.should respond_to(:cols)
				subject.should respond_to(:rows)
				subject.should respond_to(:cell_grid)
				subject.should respond_to(:all_cells)
				subject.should respond_to(:get_alive_cell_neighbours)
				subject.should respond_to(:apply_change_set)
				subject.should respond_to(:generate_random_live_cells)
				subject.should respond_to(:generate_from_rle)
				subject.should respond_to(:get_live_cells)
			end
			
			it "returns correct number of rows" do
				subject.rows.should eql $rows
			end

			it "returns correct number of columns" do
				subject.cols.should eql $cols
			end

			it "creates proper array with all cells" do
				subject.all_cells.count.should eql $rows * $cols
			end
		end

		describe "initialization" do

			it "creates proper cell grid" do
				subject.cell_grid.should be_an_instance_of Array
				subject.cell_grid.length.should eql $rows

				subject.cell_grid.each do |row|
					row.should be_an_instance_of Array
					row.length.should eql $cols
					row.each do |col|
						col.should be_an_instance_of Cell
					end
				end

			end

			it "applies change set properly" do
				subject.cell_grid[0][0].live!
				subject.cell_grid[0][0].should be_alive

				subject.apply_change_set([[0,false]])
				subject.cell_grid[0][0].should be_dead

				subject.apply_change_set([[0,true]])
				subject.cell_grid[0][0].should be_alive

			end

			it "generates random set of live cells" do
				subject.get_live_cells.count.should eql 0
				subject.generate_random_live_cells
				subject.get_live_cells.count.should_not eql 0
			end

			it "initializes properly from the rle class" do
				rle = Rle.new
				rle.decode_string("bo$2bo$3o!", 3, 3)

				subject.generate_from_rle(rle, 0, 0).should be_true

				subject.cell_grid[0][0].should_not be_alive
				subject.cell_grid[0][1].should be_alive
				subject.cell_grid[0][2].should_not be_alive

				subject.cell_grid[1][0].should_not be_alive
				subject.cell_grid[1][1].should_not be_alive
				subject.cell_grid[1][2].should be_alive

				subject.cell_grid[2][0].should be_alive
				subject.cell_grid[2][1].should be_alive
				subject.cell_grid[2][2].should be_alive

			end

			it "fails to initialize if row and col offset is negative" do
				rle = Rle.new
				rle.decode_string("bo$2bo$3o!", 3, 3)

				subject.generate_from_rle(rle, -1, -1).should be_false
			end

			it "fails to initialize if row and col offset is out of world range" do
				rle = Rle.new
				rle.decode_string("bo$2bo$3o!", 3, 3)

				subject.generate_from_rle(rle, 100, 100).should be_false
			end

			it "fails to initialize if the pattern would exceed the world range" do
				rle = Rle.new
				rle.decode_string("bo$2bo$3o!", 3, 3)

				subject.generate_from_rle(rle, 2, 2).should be_false
			end
		end

		describe "detection methods" do
			it 'detect alive cell to the North' do
				subject.cell_grid[cell.row-1][cell.col].live!
				subject.cell_grid[cell.row-1][cell.col].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the North-West' do
				subject.cell_grid[cell.row-1][cell.col-1].live!
				subject.cell_grid[cell.row-1][cell.col-1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the North-East' do
				subject.cell_grid[cell.row-1][cell.col+1].live!
				subject.cell_grid[cell.row-1][cell.col+1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the West' do
				subject.cell_grid[cell.row][cell.col-1].live!
				subject.cell_grid[cell.row][cell.col-1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the East' do
				subject.cell_grid[cell.row][cell.col+1].live!
				subject.cell_grid[cell.row][cell.col+1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the South' do
				subject.cell_grid[cell.row+1][cell.col].live!
				subject.cell_grid[cell.row+1][cell.col].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the South-West' do
				subject.cell_grid[cell.row+1][cell.col-1].live!
				subject.cell_grid[cell.row+1][cell.col-1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end

			it 'detect alive cell to the South-East' do
				subject.cell_grid[cell.row+1][cell.col+1].live!
				subject.cell_grid[cell.row+1][cell.col+1].should be_alive

				subject.get_alive_cell_neighbours(cell).count.should eql 1
			end
		end
	end
end