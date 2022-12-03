input = DATA.read().split().map { |a| a.bytes.map { |x| x - (x >= "a".ord ? "a".ord - 1 : "A".ord - 27) } }

p input.map { |a| [a[..a.length / 2 - 1], a[a.length / 2..]] }.map { (_1 & _2).first }.sum
p input.each_slice(3).map { |a| a.inject(:&).first }.sum

__END__
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
