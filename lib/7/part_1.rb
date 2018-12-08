require 'set'

rules = File.readlines('input.txt', chomp: true).map { |line| line.scan(/Step (.) .+ (.) can begin/).flatten }

conditions = Hash.new { |h, k| h[k] = Set.new }
letters = SortedSet.new

rules.each do |precedes, step|
  letters += [precedes, step]
  conditions[step] << precedes
end

combination = Set.new

loop do
  combination << letters.find { |letter| (conditions[letter] - combination).empty? }
  letters -= combination
  break if letters.empty?
end

puts combination.to_a.join
