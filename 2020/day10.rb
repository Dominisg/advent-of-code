input = ''

if __FILE__ == $PROGRAM_NAME
  result = { '1' => 0, '3' => 1 }
  one_group = 0
  one_groups = []
  chain = input.split("\n").map(&:to_i).push(0).sort
  chain.each_cons(2) do |a, b|
    if (diff = b - a) == 1
      one_group += 1
    else
      one_groups.push(one_group+1)
      one_group = 0
    end
    result[diff.to_s] += 1
  end
  one_groups.push(one_group+1)
  p result['1'] * result['3']
  p one_groups
  p one_groups.select{ |a| a > 2 }.map { |g| 2**(g - 2) - (1..(g - 4)).sum }.reduce(&:*)
end
