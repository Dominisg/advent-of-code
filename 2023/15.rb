INPUT = DATA.read().strip.split(",")
BOXES = Array.new(256) { {} } 

hash = -> (str) {
    val = 0
    str.chars.each{ |c| val = ((val + c.ord) * 17) % 256 }
    val
}

p INPUT.map{ |str| hash.(str) }.sum

INPUT.map { |str|
    if str.include?('-')
        label = str.chomp('-')
        BOXES[hash.(label)].delete(label) 
    else
        label, factor = str.split('=')
        BOXES[hash.(label)][label] = factor.to_i
    end
}

p BOXES.map.with_index{ |h, i| h.map.with_index { |(_,value), index| (i + 1) * (1 + index) * value }.sum }.sum
__END__
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7