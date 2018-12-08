require 'set'

number_of_workers = 5
time_to_process = 60

rules = File.readlines('input.txt', chomp: true).map { |line| line.scan(/Step (.) .+ (.) can begin/).flatten }

conditions = Hash.new { |h, k| h[k] = Set.new }
letters = SortedSet.new

rules.each do |precedes, step|
  letters += [precedes, step]
  conditions[step] << precedes
end

combination = Set.new
workers = number_of_workers.times.map { |n| [n, Array.new] }.to_h
seconds_passed = 0

loop do
  workers.reject { |_, working| working.empty? }.each do |_, working|
    if (worked_letter = working.pop) && working.empty?
      combination << worked_letter
      letters -= combination
    end
  end

  to_process = letters.select { |letter| (conditions[letter] - combination).empty? } - workers.values.flatten
  to_process.zip(workers.select { |_, working| working.empty? }).each do |letter, worker|
    break if worker.nil?
    (('A'..'Z').find_index(letter) + time_to_process + 1).times.each { |_| worker.last << letter }
  end

  break if letters.empty?

  seconds_passed += 1
end

puts seconds_passed
