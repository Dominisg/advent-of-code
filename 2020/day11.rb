input = ''

def simulation(input, empty_counts)
  stabilized = false
  until stabilized
    stabilized = true
    output = input.map(&:clone)
    (0..input.length - 1).each do |y|
      (0..input[0].length - 1).each do |x|
        next if input[y][x] == '.'
        x_ = 0; y_ = 0
        occupied = input[y][x] == '#' ? 1 : 0
        occupied_adjacent_count = 0
        (-1..+1).each do |i|
          (-1..+1).each do |j|
            inc = 1
            loop do
              x_ = x + i * inc
              y_ = y + j * inc
              break if empty_counts
              break if x_.negative? || (x_ >= input[0].length)
              break if y_.negative? || (y_ >= input.length)
              break if input[y_][x_] != '.'
              inc += 1
            end

            next if x_.negative? || (x_ >= input[0].length)

            next if y_.negative? || (y_ >= input.length)

            occupied_adjacent_count += 1 if input[y_][x_] == '#'
          end
        end
        if occupied_adjacent_count.zero?
          stabilized = false
          output[y][x] = '#'
        end
        if occupied_adjacent_count >= 6 && occupied == 1
          stabilized = false
          output[y][x] = 'L'
        end
      end
    end
    input = output.map(&:clone)
  end
  sum = 0
  output.map { |a| sum += a.scan(/#/).count }
  sum
end


if __FILE__ == $PROGRAM_NAME
  input = input.split("\n")
  p simulation(input, true)
  p simulation(input, false)
end
