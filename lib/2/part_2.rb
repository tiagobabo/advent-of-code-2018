def difference(a, b)
  a.chars.map.with_index.count { |char, i| char != b[i] }
end

def remove_equal_char(a, b)
  a.chars.select.with_index { |char, i| char == b[i] }.join
end

ids = File.readlines('input.txt', chomp: true)
ids.each do |id|
  ids.each do |comparing_id|
    if difference(id, comparing_id) == 1
      puts remove_equal_char(id, comparing_id)
      exit
    end
  end
end
