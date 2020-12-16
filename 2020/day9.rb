require 'set'
input = ''

PREAMBLE = 25
if __FILE__ == $PROGRAM_NAME
  input = input.split("\n").map(&:to_i)

  searched = 0
  indexes = SortedSet.new
  (PREAMBLE..input.length).each do |i|
    found = false
    input[i - PREAMBLE..i - 1].combination(2).each { |a, b| found = true if input[i] == a + b }
    unless found
      searched = i
      p input[i]
      break
    end
  end

  sum = 0
  (0..searched - 1).each do |i|
    sum += input[i]
    indexes.add(i)

    while sum > input[searched]
      o = indexes.to_a[0]
      sum -= input[o]
      indexes = indexes.delete(o)
    end
    break if sum == input[searched]
  end

  result = input.values_at(*indexes)
  p result.max + result.min
end

