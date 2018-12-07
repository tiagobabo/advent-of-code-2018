coordinates = File.readlines('input.txt', chomp: true).map { |n| n.split(", ").map(&:to_i) }

min_x, max_x = coordinates.map(&:first).minmax
min_y, max_y = coordinates.map(&:last).minmax

valid_areas = Array.new(0)

def distance(px, py, x, y)
  (px - x).abs + (py - y).abs
end

(min_x - 1..max_x - 1).each do |x|
  (min_y - 1..max_y - 1).each do |y|
    distances = coordinates.map { |cx, cy| [cx, cy, distance(cx, cy, x, y)] }
    min = distances.min_by { |_, _, distance| distance }[2]
    same_distance_coordinates = distances.select { |_, _, d| d == min }

    if same_distance_coordinates.count == 1
      cx, cy, _ = same_distance_coordinates.first
      valid_areas << [cx, cy] if cx > min_x && cx < max_x && cy > min_y && cy < max_y
    end
  end
end

puts valid_areas.uniq.map { |n| valid_areas.count(n) }.max
