class Life
	attr_accessor :rows, :cols, :cell_grid, :cells

	def initialize(rows=3, cols=3)
		@rows = rows
		@cols = cols
		@cells = []
		@cell_grid = Array.new(rows) do |row|
			          Array.new(cols) do |col|
			          	 cell = Cell.new(row, col)
			          	 cells << cell
			          	 cell
			          end	
		            end
	end	

	def live_neighbours_around_cell(cellObj)
	    neighbours_arr = []
		# puts cellObj.inspect

		### North Neighbour
		if cellObj.y > 0
			referencedCell = self.cell_grid[cellObj.y - 1][cellObj.x]
			neighbours_arr << referencedCell if referencedCell.alive?
		end	

        #### North-east neighbour
		if cellObj.y > 0 && cellObj.x < (cols - 1)
			referencedCell = self.cell_grid[cellObj.y - 1][cellObj.x + 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end	

        #### North-west neighbour
		if cellObj.y > 0 and cellObj.x > 0
			referencedCell = self.cell_grid[cellObj.y - 1][cellObj.x - 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end	

        #### South neighbour
		if cellObj.y < (rows - 1) 
			referencedCell = self.cell_grid[cellObj.y + 1][cellObj.x]
			neighbours_arr << referencedCell if referencedCell.alive?
		end	

        #### East neighbour
		if cellObj.x < (cols - 1)
			referencedCell = self.cell_grid[cellObj.y][cellObj.x + 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end							


        #### West neighbour
		if cellObj.x > 0
			referencedCell = self.cell_grid[cellObj.y][cellObj.x - 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end	

        #### South-West neighbour
		if cellObj.y < (rows - 1) and cellObj.x > 0
			referencedCell = self.cell_grid[cellObj.y + 1][cellObj.x - 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end


        #### South-East neighbour
		if cellObj.y < (rows - 1) and cellObj.x < (cols - 1)
			referencedCell = self.cell_grid[cellObj.y + 1][cellObj.x + 1]
			neighbours_arr << referencedCell if referencedCell.alive?
		end


		# puts neighbours_arr.inspect
		return neighbours_arr
	end	

	def populate_life
		cells.each do |cell|
			cell.alive = [true, false].sample
		end	
	end
	
	def live_cells
		cells.select{|cell| cell.alive}
	end	
end	

class Cell
	attr_accessor :alive, :x, :y
	def initialize(x=0, y=0)
		@alive = false
		@x = x
		@y = y 
	end	

    def die!
    	@alive = false
    end	

	def alive?
		return @alive
	end	

	def dead?
		return !@alive
	end	

	def makeAgain!
		@alive = true
	end		

end	

class Game
	attr_accessor :life, :seeds

	def initialize(life=Life.new, seeds=[])
		@life = life
		@seeds = seeds

		seeds.each do |seed|
			life.cell_grid[seed[0]][seed[1]].alive = true
		end	
	end	


	def tick!
		next_round_live_cells = []
		next_round_dead_cells = []

		life.cells.each do |cell|

			##Rule 1
			if cell.alive? and life.live_neighbours_around_cell(cell).count < 2
				next_round_dead_cells << cell
			end	

            # Rule 2
			if cell.alive? and ([2, 3].include? life.live_neighbours_around_cell(cell).count)
				next_round_live_cells << cell
			end	

           # Rule 3
			if cell.alive? and life.live_neighbours_around_cell(cell).count > 3
				next_round_dead_cells << cell
			end	


            # Rule 4
			if cell.alive? and life.live_neighbours_around_cell(cell).count == 3
				next_round_live_cells << cell
			end	

			next_round_live_cells.each do |cell|
				cell.makeAgain!
			end	

			next_round_dead_cells.each do |cell|
				cell.die!
			end	

		end	
	end	
end	
