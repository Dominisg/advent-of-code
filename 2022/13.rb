input = DATA.read().split("\n\n").map { |a| a.split().map { |b| eval(b) } }
dividers = [[[2]], [[6]]]

def cmp(a, b)
  if a.is_a? Integer
    return (b - a).clamp(-1, 1) if (b.is_a? Integer)
    return cmp([a], b)
  end

  return cmp(a, [b]) if (b.is_a? Integer)

  len = [a.length, b.length].max
  (0..len - 1).each { |i|
    return 1 if i >= a.length
    return -1 if i >= b.length

    cmp = cmp(a[i], b[i])
    return cmp if cmp != 0
  }

  0
end

p input.map { |l, r| cmp(l, r) }.map.with_index { |a, i| a >= 1 ? i + 1 : 0 }.sum

input = input.flatten(1) + dividers
input.sort! do |a, b| cmp(b, a) end
p input.map.with_index { |a, i| (dividers.include? a) ? i + 1 : 1 }.inject(:*)

__END__
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
