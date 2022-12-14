require "matrix"
input = DATA.read.split("\n").map { |a| a.split(" -> ").map { |b| b.scan(/\d+/).map(&:to_i) } }

m = Matrix.build(1000, 1000) { 0 }
void = 0

input.each { |line|
  line.each_cons(2) { |cu, ne|
    bx, ex = [cu[0], ne[0]].sort
    by, ey = [cu[1], ne[1]].sort

    void = ey > void ? ey : void

    (bx..ex).each { |_x| (by..ey).each { |_y| m[_x, _y] = 1 } }
  }
}

def simulate(_map, lowest, floor = nil)
  map = _map.clone
  count = 0
  stable = false

  (0..map.column_count - 1).each { |x| map[x, floor] = 1 } if floor != nil

  while !stable
    next_pos = Vector[500, 0]
    moving = true
    while moving
      next_pos += Vector[0, 1]

      if floor == nil and next_pos[1] > lowest
        stable = true
        break
      end

      next if map[next_pos[0], next_pos[1]] == 0

      next_pos[0] -= 1
      next if map[next_pos[0], next_pos[1]] == 0

      next_pos[0] += 2
      next if map[next_pos[0], next_pos[1]] == 0

      pos = next_pos - Vector[1, 1]
      count += 1
      moving = false
    end

    stable = true if pos == Vector[500, 0]
    map[pos[0], pos[1]] = 2
  end
  count
end

p simulate(m, void)
p simulate(m, void, void + 2)

__END__
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
