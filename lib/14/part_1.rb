scoreboard = [3, 7]
player_1 = 0
player_2 = 1
input = 260321

while scoreboard.length < input + 10 do
  player_1_recipe = scoreboard[player_1]
  player_2_recipe = scoreboard[player_2]

  next_recipes = (player_1_recipe + player_2_recipe).to_i.digits.reverse
  scoreboard.concat(next_recipes)

  scoreboard_length = scoreboard.length

  player_1 = (1 + player_1_recipe + player_1) % scoreboard_length
  player_2 = (1 + player_2_recipe + player_2) % scoreboard_length
end

puts scoreboard[input..input + 9].join
