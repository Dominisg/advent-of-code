capacity = 70000000
needed = 30000000
lines = DATA.readlines(chomp: true).map { |a| a.split() }.drop(1)

class DirNode
  attr_accessor :children, :name, :parent, :size

  def initialize(s, p = nil)
    @name = s[1]
    @parent = p
    @size = s[0] == "dir" ? 0 : s[0].to_i
    @ssize = 0
    @children = []
  end

  def subtree_size()
    if @ssize == 0 && children.length > 0
      @ssize = children.map(&:subtree_size).reduce(:+) + children.map(&:size).reduce(:+)
    end
    @ssize
  end

  def dirs()
    children.map(&:dirs).flatten + (subtree_size() > 0 ? [{ :name => @name, :size => subtree_size() }] : [])
  end
end

cur = root = DirNode.new("dir /")

while lines.length > 0
  cmd = lines.shift
  raise "Not a command!" if cmd[0] != "$"

  case cmd[1]

  when "ls"
    while lines.length > 0 && lines.first[0] != "$"
      cur.children << DirNode.new(lines.shift, cur)
    end
  when "cd"
    cur = cmd[2] == ".." ? cur.parent : cur.children.filter { |c| c.name == cmd[2] }.first
  end
end

p root.dirs().map { |h| h[:size] }.filter { |d| d <= 100000 }.sum

free = capacity - root.subtree_size()
p root.dirs().filter { |h| h[:size] > needed - free }.sort_by { |h| h[:size] }.first[:size]

__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
