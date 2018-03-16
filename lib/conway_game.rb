require 'set'

def fresh_board
  Hash.new do |h, key|
    h[key] = Hash.new(false)
  end
end

class ConwayGame
  def initialize(initial_state)
    @board = fresh_board

    initial_state.each_with_index do |row, x|
      row.each_with_index do |value, y|
        @board[x][y] = value
      end
    end
  end
  attr_reader :board

  def step
    next_board = fresh_board

    return if x_range.nil?
    return if y_range.nil?

    # Need to explore slightly beyond our bounds
    min_x = x_range.min - 1
    max_x = x_range.max + 1
    min_y = y_range.min - 1
    max_y = y_range.max + 1

    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        value = board[x][y]
        neighbor_count = alive_neighbor_count(x, y)
        # puts "#{x} #{y} #{neighbor_count}"
        if neighbor_count == 3
          next_board[x][y] = true
        elsif neighbor_count == 2 && value
          next_board[x][y] = true
        end
      end
    end

    @board = next_board
  end

  def x_range
    x_vals = board.keys
    return nil if x_vals.empty?
    (x_vals.min..x_vals.max)
  end

  def y_range
    y_vals = Set.new(board.flat_map { |_, row| row.keys })
    return nil if y_vals.empty?
    (y_vals.min..y_vals.max)
  end

  def to_s
    return '' if x_range.nil?
    return '' if y_range.nil?

    x_range.map do |x|
      y_range.map do |y|
        if @board[x][y]
          'o'
        else
          ' '
        end
      end.join('')
    end.join("\n")
  end

  def alive_neighbor_count(x, y)
    count = 0
    neighbors_around(x, y) do |neighbor_value|
      count += 1 if neighbor_value
    end
    count
  end

  def neighbors_around(x, y, &block)
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        next if dx == 0 && dy == 0

        nx = x + dx
        ny = y + dy
        val = @board[nx][ny]
        # puts "#{nx} #{ny} #{val}"
        block.call(val)
      end
    end
  end
end
