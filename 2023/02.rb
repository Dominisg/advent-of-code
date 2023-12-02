input = DATA.read
    .gsub(/Game \d+: /, '')
    .gsub(/red|blue|green/, 'red' => 0, 'green' => 1, 'blue' => 2)
    .split("\n").map { |l| l.split(';').map { |r| r.scan(/\d+/).map(&:to_i) } }

p input.map { |game|
    game.map { |set|
        set.each_slice(2).map { |count, idx| [12, 13, 14][idx] < count ? false : true }
    }.flatten.reduce(:&)
}.map.with_index { |a, i| a ? i + 1 : nil }.compact.sum

p input .map { |game|
    game.map { |set|
        min = [0, 0, 0]
        set.each_slice(2) { |count, idx| min[idx] = count if min[idx] < count }
        min
    }.transpose.map(&:max).reduce(:*)
}.sum

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
