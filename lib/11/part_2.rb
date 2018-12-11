grid_serial_number = 9798
sum_table = Hash.new

(1..300).each do |y|
  (1..300).each do |x|
    rack_id = x + 10
    score = (((rack_id * y + grid_serial_number) * rack_id).digits[2] || 0) - 5
    sum_table[[x, y]] = score +
      sum_table.fetch([x, y - 1], 0) +
      sum_table.fetch([x - 1, y], 0) -
      sum_table.fetch([x - 1, y - 1], 0)
  end
end

best_score = 0
max_height = nil
point = nil

(1..300).each do |i|
  (i..300).each do |x|
    (i..300).each do |y|
      next if x + i > 300 || y + i > 300

      score = sum_table[[x, y]] +
        sum_table[[x + i, y + i]] -
        sum_table[[x + i, y]] -
        sum_table[[x, y + i]]

      if score > best_score
        best_score = score
        max_height = i
        point = [x + 1, y + 1]
      end
    end
  end
end

puts "#{point.join(',')},#{max_height}"
