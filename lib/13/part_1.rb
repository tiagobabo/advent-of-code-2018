require 'ostruct'

map = Hash.new
players_horizontal_chars = [ '>', '<']
players_vertical_chars = ['^', 'v']
players = Array.new

intersection_options = [:left, :straight, :right]

File.readlines('input.txt', chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    next if char == ' '
    if players_horizontal_chars.include? char
      players.push OpenStruct.new(y: y, x: x, char: char, intersections: intersection_options.clone)
      map[[y, x]] = '-'
    elsif players_vertical_chars.include? char
      players.push OpenStruct.new(y: y, x: x, char: char, intersections: intersection_options.clone)
      map[[y, x]] = '|'
    else
      map[[y, x]] = char
    end
  end
end

overlaping_position = nil

loop do
  overlaping_position = nil
  players.sort_by! { |player| [player.y, player.x] }.each do |player|
    case player.char
    when '>'
      next_pos = map[[player.y, player.x + 1]]

      if next_pos == '/'
        player.char = '^'
      elsif next_pos == '\\'
        player.char = 'v'
      elsif next_pos == '+'
        if player.intersections.first == :right
          player.char = 'v'
        elsif player.intersections.first == :left
          player.char = '^'
        end

        player.intersections.rotate!
      end

      player.x += 1
    when '<'
      next_pos = map[[player.y, player.x - 1]]

      if next_pos == '/'
        player.char = 'v'
      elsif next_pos == '\\'
        player.char = '^'
      elsif next_pos == '+'
        if player.intersections.first == :right
          player.char = '^'
        elsif player.intersections.first == :left
          player.char = 'v'
        end

        player.intersections.rotate!
      end

      player.x -= 1
    when '^'
      next_pos = map[[player.y - 1, player.x]]

      if next_pos == '/'
        player.char = '>'
      elsif next_pos == '\\'
        player.char = '<'
      elsif next_pos == '+'
        if player.intersections.first == :right
          player.char = '>'
        elsif player.intersections.first == :left
          player.char = '<'
        end

        player.intersections.rotate!
      end

      player.y -= 1
    when 'v'
      next_pos = map[[player.y + 1, player.x]]

      if next_pos == '/'
        player.char = '<'
      elsif next_pos == '\\'
        player.char = '>'
      elsif next_pos == '+'
        if player.intersections.first == :right
          player.char = '<'
        elsif player.intersections.first == :left
          player.char = '>'
        end

        player.intersections.rotate!
      end

      player.y += 1
    end

    overlaping_positions = players.map { |p| [p.x, p.y] }
    overlaping_position = overlaping_positions.find { |n| overlaping_positions.count(n) > 1 }
    break if overlaping_position
  end

  break unless overlaping_position.nil?
end

puts overlaping_position.join(",")

