require 'date'

timestamps = File.readlines('input.txt', chomp: true).map { |line| line.scan(/\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] (.+)/).flatten }
timestamps = timestamps.map do |year, month, day, hour, minute, action|
  [DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i), action]
end

sleep_schedule = Hash.new { |h, k| h[k] = Hash.new(0) }
current_guard = nil
sleep_started_at_min = nil

timestamps.sort_by(&:first).each do |timestamp, action|
  case action
  when /Guard #(\d+) begins shift$/i
    current_guard = $1.to_i
  when 'falls asleep'
    sleep_started_at_min = timestamp.min
  when 'wakes up'
    (sleep_started_at_min...timestamp.min).each do |n|
      sleep_schedule[current_guard][n] += 1
    end
  end
end

winner_guard, minutes = sleep_schedule.max_by { |_, v| v.values.max }

puts winner_guard * minutes.keys.max_by(&minutes)
