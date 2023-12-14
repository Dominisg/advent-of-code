INPUT = DATA.read().split("\n").map(&:chars)

cycle =-> (input, sides, n) {
    setups = {}
    break_after = n
    
    (n).times { |k|
        (sides).times { |dir|
            range = (0..input.size - 1)
            i_sign = -1 
            x,y = dir % 2 == 1 ? [1,0] : [0,1]

            if dir > 1
                range = range.to_a.reverse  
                i_sign = 1
            end

            range.each { |yi|
                range.each { |xi|
                    next if input[yi][xi] != 'O'
                    
                    loops = y == 1 ? yi : xi
                    loops = input.size - loops - 1 if dir > 1

                    loops.times { |i|
                        i = (1 + i) * i_sign
                        break if input[yi + i * y][xi + i * x] != '.'
                        input[yi + (i - 1 * i_sign) * y][xi + (i - 1 * i_sign) * x] = '.'
                        input[yi + i * y][xi + i * x] = 'O'
                    }
                }
            }
        }

        d = INPUT.map(&:join).join
        break_after = ((n - 1) - setups[d]) % (k - setups[d]) if setups[d] != nil
        setups[d] = k

        break if break_after == 0 
        break_after -= 1
    }

INPUT.map.with_index{ |row, i| row.select { |c| c == 'O' }.count * (row.length - i) }.sum
}

p cycle.(INPUT, 1, 1)
p cycle.(INPUT, 4, 1000000000)

__END__
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....