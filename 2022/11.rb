input = DATA.read().split("\n\n").map { |a|
  a.split("\n")
    .drop(1)
    .map.with_index {
    |b, i|
    i == 1 ? b.split(":")[1] : b.scan(/\d+/).map(&:to_i)
  }.map.with_index { |b, i| i > 1 ? b.first : b } + [[0]]
}

def simulate(input, n, relief)
  monkeys = Marshal.load(Marshal.dump(input))
  modulo = monkeys.map { |a| a[2] }.inject(&:*)

  n.times {
    monkeys.each { |queue, op, div, t, f, count|
      while (queue.length != 0)
        count[0] += 1
        old = queue.shift % (modulo)
        eval(op) # op in format 'new = old ...'
        new /= 3 if relief
        monkeys[new % div == 0 ? t : f][0] << new
      end
    }
  }

  monkeys.map { |a| a[5][0] }.max(2).inject(&:*)
end

p [simulate(input, 20, true), simulate(input, 10_000, false)]

__END__
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
