claims = File.readlines('input.txt', chomp: true)
fabric = Hash.new(0)

claims = claims.map do |claim|
  claim.scan(/(\d+)/).flatten.map(&:to_i)
end.to_a

claims.each do |_, left, top, width, height|
  next if width == 0 || height == 0

  1.upto(width) do |x|
    1.upto(height) do |y|
      fabric[[left + x, top + y]] += 1
    end
  end
end

winner = claims.find do |_, left, top, width, height|
  1.upto(width).all? do |x|
    1.upto(height).all? do |y|
      fabric[[left + x, top + y]] == 1
    end
  end
end

puts winner.first
