input = ''

if __FILE__ == $PROGRAM_NAME
  # Task 1.
  instructions = input.split("\n")
  directions = %w[S W N E]
  facing = 'E'
  x = 0; y = 0
  instructions.each do |instr|
    opcode = instr[0]; val = instr[1..-1].to_i
    if %w[R L].include? opcode
      idx = directions.index(facing)
      idx += (opcode == 'R' ? val / 90 : -val / 90)
      facing = directions[idx % 4]
      next
    end
    opcode = facing if opcode == 'F'
    x += val if opcode == 'E'
    x -= val if opcode == 'W'
    y += val if opcode == 'N'
    y -= val if opcode == 'S'
  end
  p x.abs + y.abs
  # Task 2.
  position = [0, 0]
  waypoint = [10, 1]
  instructions.each do |instr|
    opcode = instr[0]; val = instr[1..-1].to_i
    if %w[R L].include? opcode
      (0..val / 90 - 1).each do
        if opcode == 'R'
          x_ = waypoint[1]
          y_ = -waypoint[0]
        elsif opcode == 'L'
          x_ = -waypoint[1]
          y_ = waypoint[0]
        end
        waypoint = x_, y_
      end
      next
    end
    if opcode == 'F'
      position[0] += waypoint[0] * val
      position[1] += waypoint[1] * val
    end
    waypoint[0] += val if opcode == 'E'
    waypoint[0] -= val if opcode == 'W'
    waypoint[1] += val if opcode == 'N'
    waypoint[1] -= val if opcode == 'S'
  end
  p position[0].abs + position[1].abs

end
