require 'set'

input = ''
def masks(mask, n)
  return [''] if n.negative?

  masks1 = masks(mask, n - 1)
  masks2 = masks1.map(&:dup)
  return masks1.map{ |s| s.concat('1') } + masks2.map{ |s| s.concat('0') } if mask[n] == 'X'
  return masks1.map!{ |s| s.concat(mask[n]) }
end

if __FILE__ == $PROGRAM_NAME
  input = input.split("\n").map { |s| s.split(' = ') }
  memory = {}
  mask_or = mask_and = 0
  input.each do |command|
    if command[0] == "mask"
      mask_and = command[1].tr('X', '1').to_i(2)
      mask_or = command[1].tr('X', '0').to_i(2)
    else
      memory[command[0]] = command[1].to_i & mask_and | mask_or
    end
  end
  p memory.values.sum

  memory = {}
  masks = []
  input.each do |command|
    if command[0] == "mask"
      masks = masks(command[1], 35)
      mask_and = command[1].tr('0', '1').tr('X', '0')
    else
      masks.each do |mask|
        memory[(command[0][4..-2].to_i & mask_and.to_i(2)) | mask.to_i(2) ] = command[1].to_i
      end
    end
  end

  p memory.values.sum
end
