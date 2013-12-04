require 'rubygems'
require 'gosu'
require 'trollop'
require_relative 'game.rb'


module ZOrder
  Background, Stars, Player, UI = *0..3
end

class GameWindow < Gosu::Window
	def initialize width = 800, height = 600, scale = 10, file_name = nil
		@width = width
		@height = height

		super width, height, false

		# Color definitions
		@background_color = Gosu::Color.new(0xffdedede)
		@alive_color = Gosu::Color.new(0xff121212)
		@dead_color = Gosu::Color.new(0xffededed)

		# Fonts
		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		@font_color = 0xffff0000;

		# Game class initialization
		@rows = height / scale
		@cols = width / scale

		@column_width = width / @cols
		@row_height = height / @rows

		@world = World.new(@rows, @cols)

		if file_name
			rle = Rle.new
			rle.decode_file(file_name)
			if @world.generate_from_rle(rle, 0, 0)
				self.caption = "Conway's Game Of Life - #{rle.pattern_name}"
			else
				@world.generate_random_live_cells			
				self.caption = "Conway's Game Of Life - FAILED TO READ FROM FILE"
			end
		else
			@world.generate_random_live_cells			
			self.caption = "Conway's Game Of Life - random pattern"
		end


		@game = Game.new(@world)
		@generation = 0
	end

	def update
		@game.tick!
		@generation = @generation + 1
	end

	def draw
		draw_quad(
			0, 0, @background_color, 
			@width, 0, @background_color, 
			@width, @height, @background_color,
			0, @height, @background_color)

		@game.world.all_cells.each do |cell|
			if cell.alive?
				draw_quad(
					cell.col * @column_width, cell.row * @row_height, @alive_color,
					cell.col * @column_width + (@column_width - 1), cell.row * @row_height, @alive_color,
					cell.col * @column_width + (@column_width - 1), cell.row * @row_height + (@row_height - 1), @alive_color,
					cell.col * @column_width, cell.row * @row_height + (@row_height - 1), @alive_color
					)
			else
				draw_quad(
					cell.col * @column_width, cell.row * @row_height, @dead_color,
					cell.col * @column_width + (@column_width - 1), cell.row * @row_height, @dead_color,
					cell.col * @column_width + (@column_width - 1), cell.row * @row_height + (@row_height - 1), @dead_color,
					cell.col * @column_width, cell.row * @row_height + (@row_height - 1), @dead_color
					)
			end
		end

		@font.draw("xsize: #{@cols} ysize: #{@rows} gen: #{@generation}", 10, @height - 30, ZOrder::UI, 1.0, 1.0, @font_color)
	end

	def needs_cursor?
		true
	end
end

# process command line
opts = Trollop::options do
	version "Ruby Game Of Life 1.0.0 (c) 2013 Eduard Kunce"

	opt :random, "Random pattern", short: 'r'
	opt :width, "Game window width", short: 'w', default: 800
	opt :height, "Game window height", short: 'h', default: 600
	opt :file, "File name to open", type: :string, short: 'f'
	opt :scale, "Initial scale factor", short: 's', default: 10
end

Trollop::die :file, ": file not found" unless File.exist?(opts[:file]) if opts[:file]
Trollop::die :random, ": random flag nor file name present" unless opts[:file] || opts[:random]


window = GameWindow.new opts[:width], opts[:height], opts[:scale], opts[:file]
window.show