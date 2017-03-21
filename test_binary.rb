# binaryTree.rb
#
# 20170313	GH
#
#

# Classes and methods for creating/searching binary trees
module BinaryTree
  # Holds a leaf/node in a binary tree
  class Node
    attr_accessor :value, :left_leaf, :right_leaf

    def initialize(value, left_leaf = nil, right_leaf = nil)
      self.value = value

      self.left_leaf = left_leaf

      self.right_leaf = right_leaf
    end

    def to_s
      @value.to_s
    end

    def <(other)
      value < other.value
    end

    def >(other)
      value > other.value
    end
  end

  #  builds a tree from a sorted array
  def self.build_tree_sort(ary)
    return nil if ary.empty?

    return Node.new(ary[0]) if ary.length == 1

    mid = ary.length / 2

    tree = Node.new(ary[mid])

    tree.left_leaf = build_tree_sort(ary[0..mid - 1])

    tree.right_leaf = build_tree_sort(ary[mid + 1..-1])

    tree
  end

  # helper for build_tree_unsort
  def self.insert_tree(val, tree)
    return Node.new(val) if tree.nil?

    tree.left_leaf = insert_tree(val, tree.left_leaf) if val < tree.value
    tree.right_leaf = insert_tree(val, tree.right_leaf) if val > tree.value

    tree
  end

  # builds a tree from an unsorted array
  def self.build_tree_unsort(ary)
    tree = nil

    ary.each do |val|
      tree = insert_tree(val, tree)
    end

    tree
  end

  # Returns node containing value, or nil if not found
  def self.bfs(tree, value)
    found = nil

    num_compares = 0

    queue = [].push(tree) if tree

    until queue.empty? || found

      node = queue.shift

      found = (value == node.value ? node : nil)

      num_compares += 1

      queue.push(node.left_leaf) unless node.left_leaf.nil?

      queue.push(node.right_leaf) unless node.right_leaf.nil?

    end

    puts("Made #{num_compares} comparisons.")

    found
  end

  def self.dfs(value, tree)
    num_compares = 0

    found = false

    # When all left nodes have been visited and there are no remaining
    # right nodes to be visited, the loop will end when this is shifted
    # off the stack.
    stack = [].unshift(nil)

    until stack.empty?

      found = tree.value == value

      stack.unshift(tree.right_leaf) if tree.right_leaf

      num_compares += 1

      break if found

      tree = tree.left_leaf

      tree = stack.shift if tree.nil?
    end

    puts("Made #{num_compares} compares.")

    found ? tree : nil
  end

  def self.dfs_rec(value, tree)
    return nil if tree.nil?
    return tree if tree.value == value
    node = dfs_rec(value, tree.left_leaf)
    node = dfs_rec(value, tree.right_leaf) unless node
    node
  end

  # Quick view of tree, need to know if a leaf is a left or right leaf to be
  # really useful
  def self.print_tree(root)
    return if root.nil?

    queue = []

    level = 1

    queue.push(root)

    last_node_level = root

    until queue.empty?

      node = queue.shift

      print node

      print '|' if level > 1

      if node == last_node_level

        level += 1

        puts

        last_node_level = node.left_leaf unless node.left_leaf.nil?

        last_node_level = node.right_leaf unless node.right_leaf.nil?
      end

      queue.push(node.left_leaf) unless node.left_leaf.nil?

      queue.push(node.right_leaf) unless node.right_leaf.nil?

    end
  end

  print("\n\n")
end
