require "matrix"
input = DATA.read().split("\n").map { |a| a.scan(/-?\d+/).map(&:to_i) }

def nth_row(coords, n)
  max_x = 0
  coords.each { |x, _, bx, _|
    _x = [x, bx].max
    max_x = _x if _x > max_x
  }

  row = Array.new(max_x * 2)

  coords.each { |x, y, bx, by|
    distance = (x - bx).abs + (y - by).abs

    row[by] = 2 if by == n

    n_covered = distance - (y - n).abs

    if n_covered >= 0
      ((x - n_covered)..(x + n_covered)).each { |_x|
        row[_x] = 1 if row[_x] != 2
      }
    end
  }

  row
end

def single(coords, first, last)
  coords.map! { |x, y, bx, by|
    [x, y, (x - bx).abs + (y - by).abs]
  }

  count = 0
  coords.each { |x, y, distance|
    x_radius_range = ((x - distance - 1).clamp(first, last)..(x + distance + 1).clamp(first, last))
    x_radius_range.each { |_x|
      [distance + 1 - (_x - x).abs + y, #right solution
       -distance - 1 + (_x - x).abs + y] #left solution
        .filter { |a| a.between?(first, last) }
        .each { |_y|
        clear = true
        left = true
        right = true
        coords.each { |__x, __y, _distance|
          if (_x - __x).abs + (_y - __y).abs < _distance
            clear = false
            break
          end

          left = false if (_x - __x - 1).abs + (_y - __y).abs < _distance
          right = false if (_x - __x + 1).abs + (_y - __y).abs < _distance
        }

        return _x * 4_000_000 + _y if left && right && clear
      }
    }
  }
end

p [nth_row(input, 2_000_000).count(1),
   single(input, 0, 4_000_000)]

__END__
Sensor at x=3428425, y=2345067: closest beacon is at x=3431988, y=2379841
Sensor at x=928237, y=25774: closest beacon is at x=1212315, y=-161555
Sensor at x=2061220, y=2396791: closest beacon is at x=2038311, y=2495160
Sensor at x=1830400, y=2994568: closest beacon is at x=1910058, y=3117415
Sensor at x=2485733, y=2625804: closest beacon is at x=2038311, y=2495160
Sensor at x=1855873, y=3971916: closest beacon is at x=1910058, y=3117415
Sensor at x=119582, y=3929652: closest beacon is at x=311197, y=4221202
Sensor at x=1069031, y=3509672: closest beacon is at x=1910058, y=3117415
Sensor at x=3368023, y=2213635: closest beacon is at x=3431988, y=2379841
Sensor at x=3713877, y=2460862: closest beacon is at x=3431988, y=2379841
Sensor at x=3593503, y=2174008: closest beacon is at x=3507689, y=2000000
Sensor at x=501760, y=93436: closest beacon is at x=1212315, y=-161555
Sensor at x=3712703, y=214999: closest beacon is at x=3507689, y=2000000
Sensor at x=1594824, y=2790273: closest beacon is at x=1910058, y=3117415
Sensor at x=2539549, y=3190814: closest beacon is at x=1910058, y=3117415
Sensor at x=3522790, y=2671548: closest beacon is at x=3431988, y=2379841
Sensor at x=1001452, y=1327490: closest beacon is at x=1212315, y=-161555
Sensor at x=629209, y=2451628: closest beacon is at x=-416149, y=2226089
Sensor at x=2636827, y=1146266: closest beacon is at x=3507689, y=2000000
Sensor at x=3909, y=625124: closest beacon is at x=1212315, y=-161555
Sensor at x=3950231, y=3688780: closest beacon is at x=3888160, y=3226725
Sensor at x=3449978, y=2328058: closest beacon is at x=3431988, y=2379841
Sensor at x=3974214, y=2582925: closest beacon is at x=3888160, y=3226725
Sensor at x=82663, y=3225533: closest beacon is at x=311197, y=4221202
Sensor at x=1958305, y=2292045: closest beacon is at x=2038311, y=2495160
Sensor at x=3465738, y=2123353: closest beacon is at x=3507689, y=2000000
Sensor at x=2940758, y=3884337: closest beacon is at x=2746166, y=4800483
Sensor at x=3429173, y=2275591: closest beacon is at x=3431988, y=2379841
Sensor at x=1527349, y=38565: closest beacon is at x=1212315, y=-161555
Sensor at x=3049925, y=2498038: closest beacon is at x=3431988, y=2379841
Sensor at x=1593202, y=3335178: closest beacon is at x=1910058, y=3117415
Sensor at x=3175520, y=3230234: closest beacon is at x=3888160, y=3226725
