input = ''

require 'set'
def count_containing(bag_name, input)
  bags = Set.new
  input.each do |rule|
    if rule[1].include?(bag_name)
      bags.add(rule[0])
      bags.merge count_containing(rule[0], input)
    end
  end
  bags
end

def count_contained(bag_name, input)
  count = 0
  input.each do |rule|
    if rule[0].include?(bag_name)
      contained = rule[1].split(', ').map { |bag| bag.split(' ') }
      contained.each { |bag| count += bag[0].to_i * (1 + count_contained(bag[1] + ' ' + bag[2], input))}
    end
  end
  count
end

if __FILE__ == $0
  input = input.split("\n").map { |rule| rule.split(' bags contain ') }
  p count_containing('shiny gold', input).length
  p count_contained('shiny gold', input)
end
