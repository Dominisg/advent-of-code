require 'set'
input = ''

def run(input)
  acc = ip = 0
  journal = Set.new
  while ip < input.length
    return [false, acc, journal] unless journal.add?(ip)

    opcode, operand = input[ip]
    acc += operand.to_i if opcode == 'acc'
    ip += operand.to_i - 1 if opcode == 'jmp'
    ip += 1
  end
  [true, acc]
end

if __FILE__ == $PROGRAM_NAME
  input = input.split("\n").map { |a| a.split(' ') }

  ret = run(input)
  p ret[1] unless ret[0]

  ret[2].each do |i|
    opcode, = input[i]
    next if opcode != 'jmp'

    input[i][0] = 'nop'
    break if (ret = run(input))[0]

    input[i][0] = opcode
  end
  p ret[1]
end

