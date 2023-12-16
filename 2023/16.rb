require 'matrix'
require 'set'

INPUT = DATA.read().split().map(&:chars)

beam = -> (input, pos, dir, energized = Set.new(), startpoints = Set.new()) {
    pos += dir
    while pos[0] >= 0 && pos[1] >= 0 && pos[0] < input.size && pos[1] < input[0].size
        energized.add(pos.to_a)
        c = input[pos[0]][pos[1]]
        if c == '.'
        elsif c == '\\'
            dir[0],dir[1] = dir[1], dir[0]
        elsif c == '/'
            dir[0],dir[1] = -dir[1], -dir[0]
        elsif dir[1] != 0 # horizontal
            if c == '|'
                beam.(input, pos, Vector[1, 0], energized, startpoints)
                beam.(input, pos, Vector[-1, 0], energized, startpoints)
                return energized.count
            end
        else # vertical
            if c == '-'
                beam.(input, pos, Vector[0, 1], energized, startpoints)
                beam.(input, pos, Vector[0, -1], energized, startpoints)
                return energized.count
            end
        end

        pos += dir
        
        # loop detect
        return energized.count if startpoints.include?([pos, dir])
        startpoints.add([pos, dir])
    end

    energized.count
}

p beam.(INPUT, Vector[0, -1], Vector[0, 1])

results = []
INPUT.each_with_index do |y, yi|
    y.each_with_index do |x, xi|
        results.append(beam.(INPUT, Vector[yi, -1], Vector[0, 1])) if xi == 0 
        results.append(beam.(INPUT, Vector[-1, xi], Vector[1, 0])) if yi == 0
        results.append(beam.(INPUT, Vector[yi, xi + 1], Vector[0, -1])) if xi == INPUT.length - 1
        results.append(beam.(INPUT, Vector[yi + 1, xi], Vector[-1, 0])) if yi == INPUT[0].length - 1
    end
end

p results.max

__END__
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....