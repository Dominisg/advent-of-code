require "matrix"

input = Matrix[*DATA.read().split().map(&:bytes)]

height, width = input.row_size - 1, input.column_size - 1
visible = height * 2 + width * 2
max_scenic_score = 0

(1..height - 1).each { |i|
  (1..width - 1).each { |j|
    trees = [input[i, 0..j - 1].reverse, #left
             input[i, j + 1..width], #right
             input.column(j)[0..i - 1].reverse, #up
             input.column(j)[i + 1..height]] #down

    visible += trees.map(&:max).min < input[i, j] ? 1 : 0

    scenic = trees.map { |l|
      view = l.take_while { |t| t < input[i, j] }.count
      view += (view < l.length) ? 1 : 0
    }.inject(:*)

    max_scenic_score = [max_scenic_score, scenic].max
  }
}

p [visible, max_scenic_score]

__END__
30373
25512
65332
33549
35390
