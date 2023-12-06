input = DATA.read().split("\n")

solve = Proc.new { |race| 
    race.map{ |time, distance| 
        time.times.map{ |i| i * (time - i) }.select{|n| n > distance}.length
    }.inject(&:*)
}

t1 = input.map{ |l| l.scan(/\d+/).map(&:to_i) }.transpose
p solve.call(t1)

t2 = input.map{ |l| l.split.join.scan(/\d+/).map(&:to_i) }.transpose
p solve.call(t2)

__END__
Time:      7  15   30
Distance:  9  40  200