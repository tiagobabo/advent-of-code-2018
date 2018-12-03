puts File.readlines('input.txt', chomp: true).map(&:to_i).reduce(:+)
