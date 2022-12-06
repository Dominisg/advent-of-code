input = DATA.read().split().map(&:chars)

p [4, 14].map { |m|
  input.map { |s|
    s.each_cons(m).map { |a|
      a.uniq.count
    }.find_index(m)
  }.first + m
}

__END__
bvwbjplbgvbhsrlpgdmjqwftvncz
