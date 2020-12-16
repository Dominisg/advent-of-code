input = ''

if __FILE__ == $0
  valid_keys = 0
  valid_passports = 0
  passports = input.split("\n\n").map { |passport| passport.split(' ') }
  passports.each do |passport|
    dict = {}
    passport.each { |r| dict[r[0...3]] = r[4..-1] }
    next unless (%w[byr iyr eyr hgt hcl ecl pid] - dict.keys).empty?

    valid_keys += 1
    valid = true
    dict.each do |key, value|
      case key
      when 'byr'
        valid = (value.length == 4 and value.to_i.between?(1920, 2002))
      when 'iyr'
        valid = (value.length == 4 and value.to_i.between?(2010, 2020))
      when 'eyr'
        valid = (value.length == 4 and value.to_i.between?(2020, 2030))
      when 'hgt'
        valid = ((value[-2..-1] == 'cm' and value[0..-3].to_i.between?(150, 193)) || (value[-2..-1] == 'in' and value[0..-3].to_i.between?(59, 76)))
      when 'hcl'
        valid = /^#[0-9a-f]{6}$/.match?(value)
      when 'ecl'
        valid = %w[amb blu brn gry grn hzl oth].include? value
      when 'pid'
        valid = /^[0-9]{9}$/.match?(value)
      end
      p key + ' ' + value + ' ' + valid.to_s
      break if valid == false
    end
    valid_passports += 1 if valid
  end

  p valid_keys
  p valid_passports
end
