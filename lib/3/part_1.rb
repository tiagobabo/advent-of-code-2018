claims = File.readlines('input.txt', chomp: true)
fabric = Hash.new(0)

claims.each do |claim|
  _, left, top, width, height = claim.scan(/(\d+)/).flatten.map(&:to_i)

  next if width == 0 || height == 0

  1.upto(width) do |x|
    1.upto(height) do |y|
      fabric[[left + x, top + y]] += 1
    end
  end
end

puts fabric.count { |_, v| v > 1 }
