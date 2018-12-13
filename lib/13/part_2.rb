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

starting_position = 0

loop do
  players.sort_by! { |player| [player.y, player.x] }
  players[starting_position..-1].each_with_index do |player, i|
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

    overlaping_positions = players.map { |p| [p.y, p.x] }
    overlaping_positions = overlaping_positions.find_all { |n| overlaping_positions.count(n) > 1 }
    players.reject! { |p| overlaping_positions.include?([p.y, p.x]) }

    unless overlaping_positions.empty?
      starting_position = i
      redo
    end
  end

  break if players.size == 1

  starting_position = 0
end

puts "#{players.first.x},#{players.first.y}"
