require "rgl/adjacency"
require "rgl/path"
require "matrix"

cubes = DATA.read().split().map { |a| Vector[*a.split(",").map(&:to_i)] }

sum = 0
max = Vector[0, 0, 0]
cubes.each { |cube|
  sum += 6
  (0..2).each { |i| max[i] = cube[i] if cube[i] > max[i] }
  cubes.each { |c|
    sum -= 1 if (cube - c).r == 1
  }
}

p sum

gr = RGL::AdjacencyGraph.new

(-1..max[0]).step(1).each { |x|
  (-1..max[1]).step(1).each { |y|
    (-1..max[2]).step(1).each { |z|
      v = Vector[x, y, z]

      next if cubes.include? v
      gr.add_vertex(v.to_s)

      (0..2).each { |i|
        q = Vector[*v.to_a]

        q[i] -= 1
        if !cubes.include? q
          gr.add_edge(q.to_s, v.to_s)
        end

        q[i] += 2
        if !cubes.include? q
          gr.add_edge(v.to_s, q.to_s)
        end
      }
    }
  }
}

empties = []
g = gr.each_vertex { |v|
  if not gr.path?(v, Vector[-1, -1, -1].to_s)
    eval("empties << " + v)
  end
}

empties.each { |cube|
  sum -= 6
  empties.each { |c|
    sum += 1 if (cube - c).r == 1
  }
}

p sum

__END__
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
