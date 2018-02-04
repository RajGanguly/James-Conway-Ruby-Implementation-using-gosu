require 'rspec'

require_relative 'main_file.rb'

describe 'Main file' do
	let!(:life) { Life.new } 

	let!(:cell) { Cell.new(1,1) }

	context 'Life' do
		subject { Life.new }

		it 'should create a new life object' do
			expect(subject.is_a?(Life)).to be_truthy
		end	

		it 'should respond to proper methods' do
		    expect(subject).to respond_to(:rows)
		    expect(subject).to respond_to(:cols)
		    expect(subject).to respond_to(:cell_grid)
		    expect(subject).to respond_to(:live_neighbours_around_cell)
		    expect(subject).to respond_to(:cells)
	    end

	    it 'should create a proper cell grid on initialization' do
	    	expect(subject.cell_grid.is_a?(Array)).to be_truthy

	    	subject.cell_grid.each do |row|
	    		expect(row.is_a?(Array)).to be_truthy
	    		row.each do |col|
	    			expect(col.is_a?(Cell)).to be_truthy
	    		end	
	    	end	
	    end	

	    it 'should add all cells to the cells array' do
          expect(subject.cells.count).to eq 2500
	    end	


	    it 'should detect a top neighbour' do
	    	subject.cell_grid[cell.y - 1][cell.x].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end	

	    it 'should detect a north-east neighbour' do
	    	subject.cell_grid[cell.y - 1][cell.x + 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end

	    it 'should detect a north-west neighbour' do
	    	subject.cell_grid[cell.y - 1][cell.x - 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end


	    it 'should detect a east neighbour' do
	    	subject.cell_grid[cell.y][cell.x + 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end


	    it 'should detect a west neighbour' do
	    	subject.cell_grid[cell.y][cell.x - 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end

	    it 'should detect a south-east neighbour' do
	    	subject.cell_grid[cell.y + 1][cell.x + 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end


	    it 'should detect a south-west neighbour' do
	    	subject.cell_grid[cell.y + 1][cell.x - 1].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end


	    it 'should detect a south neighbour' do
	    	subject.cell_grid[cell.y + 1][cell.x].alive = true
	    	expect(subject.live_neighbours_around_cell(cell).count).to eq 1
	    end

	end	

	
	context 'Cell' do
		subject { Cell.new }
		it 'should create a new cell object' do
			expect(subject.is_a?(Cell)).to be_truthy
		end	
       
        it 'should respond to proper methods' do
        	expect(subject).to respond_to(:alive)
        	expect(subject).to respond_to(:x)
        	expect(subject).to respond_to(:y)
        	expect(subject).to respond_to(:alive?)
        	expect(subject).to respond_to(:die!)
        	expect(subject).to respond_to(:makeAgain!)
        end	

        it 'should initialize properly' do
        	expect(subject.alive).to be false
        end	
	end	

    context 'Game' do
        subject {Game.new}

    	it 'should create a new object' do
    		expect(subject.is_a?(Game)).to be true
    	end	

    	it 'should respond to proper methods' do
		    expect(subject).to respond_to(:life)
		    expect(subject).to respond_to(:seeds)    		
    	end	

    	it 'should initialize  properly' do
		    expect(subject.life.is_a?(Life)).to be true
		    expect(subject.seeds.is_a?(Array)).to be true    		
    	end	

    	it 'should plant seeds properly' do
    		Game.new(life, seeds=[[2,3], [3,2]])
    		expect(life.cell_grid[2][3]).to be_alive
    		expect(life.cell_grid[3][2]).to be_alive
        end

    end	

	context 'Rules' do

	let!(:game) { Game.new } 	
		context 'Any live cell with fewer than two live neighbours dies, as if caused by underpopulation' do


			it 'should kill a live cell with no neighbours' do
				game.life.cell_grid[1][1].alive = true
				expect(game.life.cell_grid[1][1].alive).to be true
				game.tick!
				game.life.cell_grid[1][1].alive = false
			end

			it 'should kill a live cell with one live neighbour' do
				game = Game.new(life, [[1,0], [2,0]])
				game.tick!
				expect(life.cell_grid[1][0]).to be_dead
				expect(life.cell_grid[2][0]).to be_dead
			end

			it 'should not kill a live cell with 2 live neighbours' do
				game = Game.new(life, [[0,1], [1,1], [2,1]])
				game.tick!
				expect(life.cell_grid[1][1]).to be_alive
			end


		end	
	end	
end