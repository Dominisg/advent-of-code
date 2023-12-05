require 'range_operators'

class Range
    def intersection(other)
        return nil if (self.max < other.begin or other.max < self.begin) 
        [self.begin, other.begin].max..[self.max, other.max].min
    end
end

def seed_to_soil(range, maps, n)
    range = range..range if range.is_a?(Integer)
    
    return [] if nil
    return [range] if n == 7

    map = maps[n]
    map.each { |rule|

        match = rule[0].intersection(range)
        return seed_to_soil((match.min + rule[1])..(match.max + rule[1]), maps, n + 1) + (range - rule[0]).map{ |r| seed_to_soil(r, maps, n)[0] } if match
    }
    
    return seed_to_soil(range, maps, n + 1)
end

input = DATA.read().split("\n\n")

seeds = input[0].scan(/\d+/).map(&:to_i)
maps = input[1..].map{ |l| l.scan(/\d+/).map(&:to_i).each_slice(3).map { |a, b, sz| [(b..b+sz), a - b] } }

p seeds.map{ |seed| seed_to_soil(seed, maps, 0).map(&:min).min }.min
p seeds.each_slice(2).map{ |s, sz| seed_to_soil((s..s+sz), maps, 0).map(&:min).min }.min

__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4