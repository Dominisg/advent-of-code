require 'matrix'

DIRS = [Vector[-1, 0],
        Vector[-1, -1],
        Vector[0, -1],
        Vector[1, 1],
        Vector[-1, 1],
        Vector[1, 0],
        Vector[0, 1],
        Vector[1, -1]]

input = DATA.read().split().map(&:bytes)

removed = []
input.each_with_index do |y, yi|
    xi = -1
    while (xi += 1) < y.length
        next if !input[yi][xi].between?('0'.ord, '9'.ord)

        digits = 0
        to_scan = [] 
        loop do 
            to_scan += DIRS.map{ |dir| dir += Vector[0, digits] }
            digits += 1
            break if xi + digits >= y.length || !input[yi][xi + digits].between?('0'.ord, '9'.ord)
        end

        erase = true
        to_scan.each { |dir|
            next if !(yi + dir[0]).between?(0, input.length - 1)
            next if !(xi + dir[1]).between?(0, y.length - 1)

            val = input[yi + dir[0]][xi + dir[1]]
            erase = false if val != '.'.ord && !val.between?('0'.ord, '9'.ord)
        }
        
        digits.times{ |i| input[yi][xi + i] = '.'.ord } if erase

        xi += digits
    end
end
p input.map{|a| a.pack('c*')}.join.scan(/\d+/).map(&:to_i).sum

gears = []
input.each_with_index do |y, yi|
    y.each_with_index do |x, xi|
    
    next if x != '*'.ord

        adjacent = []
        DIRS.each { |dir|
            valy = yi + dir[0]
            valx = xi + dir[1]
            next if !valy.between?(0, input.length - 1)
            next if !valx.between?(0, y.length - 1)
            next if !input[valy][valx].between?('0'.ord, '9'.ord)
            
            valx -= 1 while valx > 0 && input[valy][valx - 1].between?('0'.ord, '9'.ord)

            num = ''
            loop do 
                cur_len = num.length
                num += input[valy][valx + cur_len].chr
                input[valy][valx + cur_len] = '.'.ord
                break if valx + num.length >= y.length || !input[valy][valx + num.length].between?('0'.ord, '9'.ord)
            end            
            adjacent.append(num.to_i)
        }

    gears.append(adjacent[0] * adjacent[1]) if adjacent.length == 2        
    end
end
p gears.sum

__END__
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..