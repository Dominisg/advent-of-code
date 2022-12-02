input = DATA.read().split($/).map(&:bytes).map { [_1 - "A".ord, _3 - "X".ord] }

p input.map { _2 + 1 + [3, 0, 6][(_1 - _2) % 3] }.sum()
p input.map { (_1 + (_2 - 1)) % 3 + _2 * 3 + 1 }.sum()

__END__
A Y
B X
C Z
