class Node
  attr_accessor :value, :next, :prev

  def initialize(value, prev_node = nil, next_node = nil)
    self.value = value
    self.prev = prev_node || self
    self.next = next_node || self
  end

  def insert_right(value)
    new_node = Node.new(value, self, self.next)
    self.next.prev = new_node
    self.next = new_node
    new_node
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    self.next
  end
end

n_players, max_score = File.read('input.txt').scan(/(\d+)\D+(\d+)/).flatten.map(&:to_i)
max_score *= 100

players_score = Hash.new(0)
current_marble = Node.new(0)
next_marble = 1

(1..n_players).cycle do |player|
  if next_marble % 23 == 0
    to_remove = current_marble.prev.prev.prev.prev.prev.prev.prev
    players_score[player] += next_marble + to_remove.value
    current_marble = to_remove.remove
  else
    current_marble = current_marble.next.insert_right(next_marble)
  end

  next_marble += 1
  break if next_marble > max_score
end

puts players_score.max_by { |_, v| v }.last
