require "rgl/adjacency"
require "rgl/path"
require "rgl/dijkstra"
require "matrix"

DIRS = [Vector[-1, 0],
        Vector[1, 0],
        Vector[0, 1],
        Vector[0, -1]]

input = DATA.read().split().map(&:bytes)

positions = []

gr = RGL::DirectedAdjacencyGraph.new
map = {}

input.each_with_index do |x, xi|
  x.each_with_index do |y, yi|
    v = Vector[xi, yi]

    if y == "S".ord
      start = v
      input[xi][yi] = "a".ord
    else y == "E".ord
      target = v
      input[xi][yi] = "z".ord     end

    if input[xi][yi] == "a".ord
      positions << Vector[xi, yi]
    end
  end
end

input.each_with_index do |x, xi|
  x.each_with_index do |y, yi|
    v = Vector[xi, yi]

    height = input[xi][yi]
    DIRS.each_with_index { |dir, i|
      move = v + dir

      next if !(move[0].between?(0, input.length - 1) && move[1].between?(0, input[0].length - 1))

      step_height = input[move[0]][move[1]]

      next if step_height > height + 1

      gr.add_edge(v.to_s, move.to_s)
      map[[v.to_s, move.to_s]] = 1
    }
  end
end

p gr.dijkstra_shortest_path(map, start.to_s, target.to_s).length - 1
p positions.map { |a|
  gr.path?(a.to_s, target.to_s) ? r.dijkstra_shortest_path(map, a.to_s, target.to_s).length - 1 : 0
}.filter { |a| a != 0 }.min

__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
