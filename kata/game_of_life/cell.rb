class Cell
	attr_reader :alive, :row, :col

	def initialize row=0, col=0
		@alive = false
		@row = row
		@col = col
	end

	def alive?
		@alive
	end

	def dead?
		!@alive
	end

	def live!
		@alive = true
	end

	def die!
		@alive = false
	end
end