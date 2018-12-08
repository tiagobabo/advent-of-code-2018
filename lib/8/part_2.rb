def calculate_score(sequence)
  child, metadata = sequence.shift 2

  if child == 0
    sequence.shift(metadata).inject(:+)
  else
    children_scores = child.times.map { |n| [n + 1, calculate_score(sequence)] }.to_h
    sequence.shift(metadata).map { |n| children_scores[n] }.compact.inject(:+)
  end
end

sequence = File.read('input.txt').split.map(&:to_i)
puts calculate_score(sequence)
