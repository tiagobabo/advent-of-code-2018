scoreboard = '37'
player_1 = 0
player_2 = 1
input = '260321'

loop do
  scoreboard << (scoreboard[player_1].to_i + scoreboard[player_2].to_i).to_s

  player_1 = (1 + scoreboard[player_1].to_i + player_1) % scoreboard.length
  player_2 = (1 + scoreboard[player_2].to_i + player_2) % scoreboard.length

  break if scoreboard.end_with?(input) || (scoreboard[-1 * (input.length + 1)..-2] || "").end_with?(input)
end

if scoreboard.end_with?(input)
  puts scoreboard.length - input.length
else
  puts scoreboard.length - input.length - 1
end
