require "rgl/adjacency"
require "rgl/path"
require "rgl/dijkstra"
require "rgl/dot"

def single_flow(v, closed, n, rates, distances)
  closed -= [v]

  return -rates[v] * n if n <= 0
  return 0 if closed.length == 0

  return closed.map { |a|
           n - distances[v + "->" + a] <= 0 ? 0 :
             single_flow(a, closed, n - distances[v + "->" + a], rates, distances) + rates[a] * (n - distances[v + "->" + a])
         }.max
end

input = DATA.read().split("\n").map { |a| a.scan(/\d+|[A-Z]{2}/) }

map = {}
rates = {}
distances = {}

gr = RGL::AdjacencyGraph.new
input.each { |row|
  rates[row.first] = row[1].to_i
  row[2..-1].each { |v|
    gr.add_edge(row.first, v)
    map[[row.first, v]] = 1
  }
}

rates = rates.select { |_, val| val > 0 }

rates.keys.append("AA").combination(2) { |k1, k2|
  distances[k1 + "->" + k2] = gr.dijkstra_shortest_path(map, k1, k2).length
  distances[k2 + "->" + k1] = distances[k1 + "->" + k2]
}

with_elephant_flows = []
rates.keys.combination(rates.length / 2) { |a|
  with_elephant_flows << single_flow("AA", a, 26, rates, distances) +
                         single_flow("AA", rates.keys - a, 26, rates, distances)
}

p [single_flow("AA", rates.keys, 30, rates, distances), with_elephant_flows.max]

__END__
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
