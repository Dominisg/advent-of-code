input = DATA.read().split().map { _1.split(",").map { |a| a.split("-").map(&:to_i) } }

p input.map { (_1.permutation(2).map { |r1, r2| r1.first >= r2.first && r1.last <= r2.last }).include?(true) }.count(true)
p input.map { |r1, r2| !(r1.first > r2.last || r1.last < r2.first) }.count(true)

__END__
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
