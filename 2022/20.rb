def mix(input, key, n)
  list = input.map.with_index { |a, i| [i, a.to_i * key] }

  n.times {
    (0..list.length - 1).each { |pos|
      found = nil
      list.each.with_index { |a, i|
        if a[0] == pos
          found = [i, a]
          break
        end
      }

      list.insert((found[0] + found[1][1]) % (list.length - 1), list.delete_at(found[0]))
    }
  }

  result = list.map { |a| a[1] }

  i = result.find_index(0)

  [1000, 2000, 3000].map { |a| result[(a + i) % (result.length)] }.sum
end

input = DATA.read().split()

p [mix(input, 1, 1), mix(input, 811589153, 10)]

__END__
1
2
-3
3
-2
0
4
