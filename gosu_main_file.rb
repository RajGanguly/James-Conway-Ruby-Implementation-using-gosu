require 'gosu'

require_relative 'main_file.rb'

class GameOfLife < Gosu::Window
  def initialize(width=760, height=480)
    
    @width = width
    @height = height
    super width, height, false

    self.caption = "Game of life"
    @background_color = Gosu::Color.new(0xff_00ffff)
    @live_color = Gosu::Color.new(0xff_0000ff)
    @dead_color = Gosu::Color.new(0xff_000000)
    @rows = @height / 10
    @cols = @width / 10
    @col_width = @width / @cols
    @row_height = @height / @rows
    @life = Life.new(@rows, @cols)
    @game = Game.new(@life)
    @game.life.populate_life

  end
  
  def update
    #@game.tick!
  end
  
  def draw
    draw_quad(0, 0, @background_color, width, 0, @background_color, width, height, @background_color, 0, height, @background_color)
    @game.life.cells.each do |cell|
    	if cell.alive
    		draw_quad(cell.x * @col_width, cell.y * @row_height, @live_color, 
    			cell.x * @col_width + @col_width, cell.y * @row_height, @live_color,
    			cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @live_color,
    			cell.x * @col_width, cell.y * @row_height + @row_height, @live_color
    			)
    	else
    		draw_quad(cell.x * @col_width, cell.y * @row_height, @dead_color, 
    			cell.x * @col_width + @col_width, cell.y * @row_height, @dead_color,
    			cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @dead_color,
    			cell.x * @col_width, cell.y * @row_height + @row_height, @dead_color
    			)    		
    	end
    end	
  end

  def needs_cursor?
  	true
  end	
end

GameOfLife.new.show