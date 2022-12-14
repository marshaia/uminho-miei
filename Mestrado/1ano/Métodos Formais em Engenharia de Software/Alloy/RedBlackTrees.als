sig Node {
	children : set Node
}
sig Leaf extends Node {}
one sig Root in Node {}

sig Red, Black in Node {}

pred Invs {

  	// Binary Trees Conditions
  	// Not Leaf Nodes must always have 2 children
	all n : Node - Leaf | #n.children=2
  
  	// Leafs have no children
  	no Leaf.children

	// Children must only have one parent
	all n : Node - Root | one children.n

	// No node can have Root has children
	all r : Root | no children.r

	// No node shall have itself as its children
	all n : Node | n not in n.^(children)

	// All nodes are reachable from the root
	Node in Root.*(children)
  
  
  	// Red-Black Trees
  	// Every node has a color either red or black.
	all n : Node | n in Black iff n not in Red

	// The root of the tree is always black
	Root in Black
  	
	// All leaf nodes are black nodes
	Leaf in Black

	// There are no two adjacent red nodes (A red node cannot have a red parent or red child)
	all n : Red | no Red & n.children

	// Every path from a node (including root) to any of its descendants Leaf nodes has the same number of black nodes
	all l1, l2 : Leaf | #(Black & ^(children).l1) = #(Black & ^(children).l2)
}

run Invs
