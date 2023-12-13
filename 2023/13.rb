class String
    def distance(s) 
        return self.chars.zip(s.chars).filter { |a, b| a != b }.count
    end
end

INPUT = DATA.read().split("\n\n")
                   .map{ |m| m.split("\n").map(&:chars) }
ROWS = INPUT.map{ |m| m.map(&:join) }
COLS = INPUT.map{ |m| m.transpose.map(&:join) }

mirror_factor = -> (m, smudges) {
    m.each_with_index { |row, i|
        break if i + 1 == m.length
        
        distance = row.distance(m[i + 1])
        if (distance <= smudges)
            [i + 1, m.length - i - 1].min.times { |j|
                next if j == 0
                
                distance += m[i + 1 + j].distance(m[i - j]) 
                break if distance > smudges
            }
            return i + 1 if distance == smudges
        end
    }
    return 0
}

p ROWS.map{ |rows| mirror_factor.(rows, 0) }.sum * 100 + COLS.map{ |cols| mirror_factor.(cols, 0) }.sum
p ROWS.map{ |rows| mirror_factor.(rows, 1) }.sum * 100 + COLS.map{ |cols| mirror_factor.(cols, 1) }.sum

__END__
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#