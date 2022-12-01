calories = DATA.read.split("\n\n").map { |l| l.split("\n").map(&:to_i).reduce(:+) }

p [1, 3].map { |i| calories.max(i).sum }

__END__
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
