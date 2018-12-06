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

puts apply_reactions(sequence).length
