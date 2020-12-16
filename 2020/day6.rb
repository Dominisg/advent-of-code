input = ''

if __FILE__ == $0
  groups =  input.split("\n\n")

  anyone = everyone = 0
  groups.each do |group|
    answers = (group.each_char.with_object(Hash.new(0)) { |c, h| h[c] += 1 })
    group_size = answers["\n"] + 1
    anyone += answers.reject { |n| n == "\n" }.length
    everyone += answers.select { |_, val| val == group_size }.length
  end

  p anyone
  p everyone
end
