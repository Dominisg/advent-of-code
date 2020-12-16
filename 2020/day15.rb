input = ''

def nth(input, n)
  spoken = {}
  (0..input.length - 2).each { |i| spoken[input[i]] = i }
  last_spoken = input[-1]

  (input.length..n - 1).each do |i|
    to_speak = if spoken.include? last_spoken
                 i - spoken[last_spoken] - 1
               else
                 0
               end
    spoken[last_spoken] = i - 1
    last_spoken = to_speak
  end
  last_spoken
end

if __FILE__ == $PROGRAM_NAME
  input = input.split(',').map(&:to_i)
  p nth(input, 2020)
  p nth(input, 30_000_000)
end
