coordinates = File.readlines('input.txt', chomp: true).map { |n| n.split(", ").map(&:to_i) }

min_x, max_x = coordinates.map(&:first).minmax
min_y, max_y = coordinates.map(&:last).minmax

valid_areas = Array.new(0)

def distance(px, py, x, y)
  (px - x).abs + (py - y).abs
end

(min_x - 1..max_x - 1).each do |x|
  (min_y - 1..max_y - 1).each do |y|
    distances = coordinates.map { |cx, cy| distance(cx, cy, x, y) }
    sum = distances.inject(:+)

    if sum < 10_000
      valid_areas << sum
    end
  end
end

puts valid_areas.count
