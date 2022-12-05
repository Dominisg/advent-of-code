input = DATA.read().split("\n\n")

procedure = input[1]
  .split("\n")
  .map { |a|
  a.scan(/\d+/).map(&:to_i)
}

stacks = input[0]
  .split("\n")
  .map(&:chars)
  .reverse
  .reduce(&:zip)
  .map { |a|
  a.flatten.filter { |x| x =~ /[A-Z]/ }
}.reject(&:empty?)

stacks_b = stacks.map(&:clone)

procedure.each { |n, s, d|
  n.times {
    stacks[d - 1].push(stacks[s - 1].pop)
  }

  stacks_b[d - 1].push(*stacks_b[s - 1].pop(n))
}

p [stacks, stacks_b].map { |s| s.map(&:last).join }

__END__
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
