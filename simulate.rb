require 'conway_game'

board = [[false, true, false], [false, false, true], [true, true, true]]
game = ConwayGame.new(board)

100.times do
  puts "--------"
  puts game.to_s
  puts "--------"
  game.step
end
puts game.x_range
puts game.y_range
