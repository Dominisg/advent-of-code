dict = { 'nineight' => '98',
         'eightwo' => '82',
         'eighthree' => '83',
         'sevenine' => '79',
         'fiveight' => '58',
         'twone' => '21',
         'oneight' => '18',
         'one' => '1',
         'two' => '2',
         'three' => '3',
         'four' => '4',
         'five' => '5',
         'six' => '6',
         'seven' => '7',
         'eight' => '8',
         'nine' => '9' }

input = DATA.read.split("\n")

p input.map { |l| l.scan(/\d/).values_at(0, -1).join.to_i }.sum

re = Regexp.new dict.keys.join('|')
p input.map { |l| l.gsub(re, dict).scan(/\d/).values_at(0, -1).join.to_i }.sum

__END__
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
