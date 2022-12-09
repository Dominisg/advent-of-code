require "set"
require "matrix"

input = DATA.read().split("\n").map(&:split)

def simulate_rope_knot(moves, len)
  dir = { "L" => Vector[-1, 0], "R" => Vector[1, 0],
          "U" => Vector[0, 1], "D" => Vector[0, -1] }

  visited = Set.new([Vector[0, 0]])
  rope = Array.new(len) { Vector[0, 0] }

  moves.each { |m|
    shift = dir[m[0]]

    m[1].to_i.times {
      rope[0] += shift
      (0..len - 2).each { |i|
        if (rope[i] - rope[i + 1]).r >= 2
          rope[i + 1] += (rope[i] - rope[i + 1]).map { |a| a.clamp(-1, 1) }

          visited.add(rope[i + 1]) if i + 1 == len - 1
        end
      }
    }
  }

  visited.count
end

p [2, 10].map { |p| simulate_rope_knot(input, p) }

__END__
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
