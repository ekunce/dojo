require 'benchmark'
require 'trollop'
require_relative 'game.rb'


opts = Trollop::options do
	opt :rows, "Number of rows in a game field", short: 'r', default: 100
	opt :cols, "Number of columns in a game field", short: 'c', default: 100
	opt :ticks, "Number of columns in a game field", short: 't', default: 100
end

world = World.new opts[:rows], opts[:cols]
world.generate_random_live_cells

game = Game.new world

Benchmark.bm(30) do |bm|
	bm.report("#{opts[:ticks]} game ticks [#{opts[:rows]}x#{opts[:cols]}]") do 
		opts[:ticks].times do
			game.tick!
		end		
	end
end
