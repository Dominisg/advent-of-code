INPUT = DATA.read().split().map(&:chars)
            .map{ |row| row.uniq.size == 1 ? ['-'] * row.length : row }
            .transpose.map{ |col| col.uniq == ['.', '-'] ? ['|'] * col.length : col }
            .transpose

galaxies = []

distance = -> (input, expand) {
    yacc = 0
    input.each_with_index do |y, yi|
        xacc = 0
        yacc += expand-1 if y.first == '-'
        y.each_with_index do |x, xi|
            xacc += expand-1 if x == '|'
            galaxies.append([xi + xacc, yi + yacc]) if x == '#'
        end
    end

    galaxies.combination(2).map{ |a, b| (a[0] - b[0]).abs + (a[1] - b[1]).abs }.sum
}

p distance.(INPUT, 2)
p distance.(INPUT, 1_000_000)

__END__
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....