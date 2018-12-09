n_players, max_score = File.read('input.txt').scan(/(\d+)\D+(\d+)/).flatten.map(&:to_i)

players_score = Hash.new(0)
played_marbles = [0]
current_position = 0
next_marble = 1

(1..n_players).cycle do |player|
  if next_marble % 23 == 0
    current_position = (current_position - 7) % played_marbles.size
    players_score[player] += next_marble + played_marbles.delete_at(current_position)
  else
    current_position = (current_position + 2) % played_marbles.size
    played_marbles.insert(current_position, next_marble)
  end

  next_marble += 1
  break if next_marble > max_score
end

puts players_score.max_by { |_, v| v }.last
