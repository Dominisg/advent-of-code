input = DATA.read().split("\n").map{ |l| l.scan(/.?\d+/).map(&:to_i) }
p input.map { |history|
    elem = [history]
    loop do 
        r = []
        elem[-1].each_cons(2) { |a, b| r.append((b - a)) }
        elem.append(r)
        break if elem[-1].uniq.size == 1
    end
    [elem.map(&:last).sum,
    elem.map(&:first).reverse.inject{|a,b| b - a}]
}.transpose.map(&:sum)

__END__
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45