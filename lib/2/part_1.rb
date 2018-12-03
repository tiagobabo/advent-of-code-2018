frequencies = File.readlines('input.txt', chomp: true).map do |line|
  line.chars.inject(Hash.new(0)) { |h, v| h[v] += 1; h }
end

twos   = frequencies.count { |n| n.values.include? 2 }
threes = frequencies.count { |n| n.values.include? 3 }

puts twos * threes
