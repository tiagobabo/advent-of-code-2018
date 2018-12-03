def find_repeated_sum(frequencies)
  @visited ||= [0]
  @sum     ||= 0

  frequencies.each do |n|
    @sum += n

    if @visited.include?(@sum)
      return @sum
    else
      @visited << @sum
    end
  end

  find_repeated_sum(frequencies)
end

puts find_repeated_sum(File.readlines('input.txt', chomp: true).map(&:to_i))
