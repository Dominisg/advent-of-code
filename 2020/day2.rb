input = ""

if __FILE__ == $0
  rules = input.split("\n").map {|rule| rule.split(" ")}
  count_1 = 0
  count_2 = 0
  rules.each { |cond, char, pass|
    range = cond.split("-").map(&:to_i)
    count_1 += 1 if pass.count(char[0]).between?(range[0], range[1])
    count_2 += 1 if (pass[range[0] - 1] == char[0]) ^ (pass[range[1] - 1] == char[0])
  }
  p count_1
  p count_2
end
