input = DATA.read()
            .split("\n")
            .map{ |l| l.split }
            .map{ |hand, bid| [hand.chars, bid.to_i] }

points = {
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14,
}
('2'..'9').each { |c| points.store(c, c.ord - '0'.ord) }

input.sort_by!{ |hand, bid| 
    hand.tally.values.sort.reverse + hand.map { |c| points[c] } 
}
p input.map.with_index { |r, i| r[1] * (i + 1) }.sum

points['J'] = 1
input.sort_by!{ |hand, bid|
    t = hand.tally
    if hand.include?('J')
        tmp = t.delete('J')
        t.store('A', 0) if t.empty?
        best = t.max_by{ |k, v| v }[0]
        t[best] += tmp 
    end 

    t.values.sort.reverse + hand.map { |c| points[c] } 
}
p input.map.with_index { |r, i| r[1] * (i + 1) }.sum

__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483