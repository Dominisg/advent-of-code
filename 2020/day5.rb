input = ''

if __FILE__ == $0
  input = input.split("\n").map { |a| a.gsub('B', '1').gsub('F', '0').gsub('R', '1').gsub('L', '0') }
  ids = input.map { |a| a.to_i(2) }
  empties = ((0...ids.max).to_a - ids)

  p ids.max
  empties.each { |seat| p seat unless empties.include?(seat-1) or empties.include?(seat+1) }
end
