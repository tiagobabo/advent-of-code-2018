sequence = File.open('input.txt', &:readline).chomp

def apply_reactions(sequence)
  final_sequence = String.new

  sequence.each_char do |c|
    if final_sequence[-1] == c.swapcase
      final_sequence.chop!
    else
      final_sequence << c
    end
  end

  final_sequence
end

initial_sequence = sequence

without_letter_x = ('a'..'z').map do |letter|
  sequence = initial_sequence.gsub(/#{letter}|#{letter.upcase}/, '')
  next unless sequence.length != initial_sequence.length
  apply_reactions(sequence).length
end

puts without_letter_x.min
