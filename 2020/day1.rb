input = ''

if __FILE__ == $0
  p input.split("\n").map(&:to_i).combination(2) {|a| p(a.inject(:*)) if a.inject(:+) == 2020}
  p input.split("\n").map(&:to_i).combination(3) {|a| p(a.inject(:*)) if a.inject(:+) == 2020}
end
