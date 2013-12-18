class World
  def initialize world
    @current_world = world
  end

  def next
    @new_world = Hash.new
    @dead_cells_of_interest = Hash.new

    @current_world.each do |coords, value|
      alive_neighbors = self.count_neighbors coords, 'alive'
      if alive_neighbors == 2 || alive_neighbors == 3
        @new_world[coords] = 1
      end
    end

    @dead_cells_of_interest.each do |coords, value|
      alive_neighbors = self.count_neighbors coords, 'dead'
      if alive_neighbors == 3
        @new_world[coords] = 1
      end
    end

    @current_world = @new_world
  end

  def print_world height, width
    puts "\e[H\e[2J"
    line = ''
    for i in 0..height
      for j in 0..width
        #if @current_world.has_key?( [( j - (0.5 * height) ).to_i, ( i - (0.5 * width) ).to_i] )
        if @current_world.has_key?( [j, i] )
          print "0"
        else
          print ' '
        end
      end
      print "\n"
    end
    
  end

  def to_hash
    @current_world
  end

  def count_neighbors coords, state
    x, y = coords
    alive_neighbors = 0
    all_neighbors = [[x,y+1],[x,y-1],[x+1,y],[x-1,y],[x+1,y+1],[x+1,y-1],[x-1,y+1],[x-1,y-1]]
    all_neighbors.each do |c|
      if @current_world.has_key?(c)
        alive_neighbors += 1
      elsif state == 'alive'
        @dead_cells_of_interest[c] = 1
      end
    end
    return alive_neighbors
  end

end
