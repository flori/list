require 'list'

list = List.new
n = (ARGV.shift || 100).to_i
n.times do |i|
  list.insert i, at: rand(list.size + 1)
  list.index(i)
end
p list.size
