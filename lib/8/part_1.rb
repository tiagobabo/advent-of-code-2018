def collect_metadata(sequence)
  child, metadata = sequence.shift 2

  child.times.map { collect_metadata(sequence) }.flatten + sequence.shift(metadata)
end

sequence = File.read('input.txt').split.map(&:to_i)
puts collect_metadata(sequence).inject(:+)
