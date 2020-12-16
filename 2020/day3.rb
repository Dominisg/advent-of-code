input = ''
def count_trees(x_step, y_step, input)
  x = 0
  trees = 0
  (0...input.length).step(y_step) do |i|
    trees += 1 if input[i][x % input[i].length] == '#'
    x += x_step
  end
  trees
end

if __FILE__ == $0
  
  input = input.split("\n")
  p count_trees(3, 1, input)
  p count_trees(1, 1, input) * count_trees(3, 1, input) * count_trees(5, 1, input) \
    * count_trees(7, 1, input) * count_trees(1, 2, input)
end
