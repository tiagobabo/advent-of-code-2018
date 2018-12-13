input = File.readlines('input.txt', chomp: true)
initial_state = input.first.scan(/initial state: (.*)/).flatten.first
rules = Hash.new
pots = Hash.new('.')
score = 0

input[2..-1].each do |line|
  sequence, result = line.scan(/(.*) => (.*)/).flatten
  rules[sequence] = result
end

initial_state.chars.each_with_index do |value, pot|
  pots[pot] = value
end

20.times do
  new_state = Hash.new('.')
  first = pots.to_a.first.first
  last = pots.to_a.last.first

  (1..2).each do |i|
    pots[first - i] = '.'
    pots[last + i] = '.'
  end

  pots.sort.to_h.each do |k, v|
    new_state[k] = rules.fetch([pots[k - 2], pots[k - 1], v, pots[k + 1], pots[k + 2]].join, '.')
  end

  pots = new_state
  score = pots.select { |_, v| v == '#' }.keys.sum
end

puts score
