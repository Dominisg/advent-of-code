require 'set'

if __FILE__ == $PROGRAM_NAME
  input = input.split("\n")
  schedule = input[1].split(',').map(&:to_f)
  buses = schedule.reject(&:zero?)
  minid = min = buses.max

  buses.each do |bus|
    time = depart = input[0].to_f
    depart += 1 while (depart / bus) % 1 > 0 && depart - time < min
    if depart - time < min
      min = depart - time
      minid = bus
    end
  end
  p (min * minid).to_i

  t = 0.0
  inc = 1
  (0..(schedule.length - 1)).reverse_each do |i|
    next if schedule[i].zero?

    t += inc until t % schedule[i] == (schedule[i] - i) % schedule[i]
    inc *= schedule[i]
  end
  p t.to_i
end
