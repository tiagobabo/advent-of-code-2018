grid_serial_number = 9798
points = Hash.new

(1..300).each do |y|
  (1..300).each do |x|
    rack_id = x + 10
    points[[x, y]] = (((rack_id * y + grid_serial_number) * rack_id).digits[2] || 0) - 5
  end
end

max_top_left = points.max_by do |(x, y), _|
  (0..2).flat_map do |px|
    (0..2).map do |py|
      points.fetch([x + px, y + py], 0)
    end
  end.inject(:+)
end

puts max_top_left.first.join(",")
