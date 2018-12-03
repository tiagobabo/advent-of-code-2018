require 'set'

visited = Set.new
frequency = 0

File.readlines('input.txt', chomp: true).map(&:to_i).cycle do |value|
  frequency += value

  if visited.include?(frequency)
    puts frequency
    break
  end

  visited << frequency
end
