points = File.readlines('input.txt', chomp: true).map do |line|
  line.scan(/(-?\d+),\s*(-?\d+)>.*<\s*(-?\d+),\s*(-?\d+)/).flatten.map(&:to_i)
end

height_before = 200_000
seconds_passed = 0

loop do
  points.each_with_index do |(_, _, plus_x, plus_y), i|
    points[i][0] += plus_x
    points[i][1] += plus_y
  end

  min_y, max_y = points.minmax_by { |_, y, _, _| y }.map { |p| p[1] }
  height = (max_y - min_y).abs

  if height > height_before
    min_x, max_x = points.minmax_by { |x, _, vx, _| x - vx }.map { |p| p[0] }

    (min_y..max_y).each do |y|
      line = (min_x..max_x).map do |x|
        points.find { |px, py, vx, vy| px - vx == x && py - vy == y} ? "#" : "."
      end.join

      puts line
    end

    puts "Seconds passed: #{seconds_passed}"

    break
  else
    height_before = height
    seconds_passed += 1
  end
end
