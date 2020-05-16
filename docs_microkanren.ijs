NB.%microkanren.ijs - a MicroKanren with rank-polymorphic unification
NB.-This script is an attempt at a mostly verbatim implementation of [scheme microkanren](https://github.com/jasonhemann/microKanren-DLS-16).\
NB.-
NB.-* Trees are represented by nested boxed arrays.\
NB.-* Variables are integers and are considered in scope if lying between zero and 1-length of the state array.\
NB.-* Promises are boxed strings, and are forced by the *execute* verb (`".`).\
NB.-* The indeterminate value (`_.`) was chosen as initial value in the state array because of its limited usefulness in the J language, and to allow unification with the empty array (`''`). `_.` is therefore a marker of the freshness of a variable.
NB.-
NB.-**CAUTION: there certainly are major bugs and misunderstandings in this, due to my inexpertise in both logic and J!**

NB.*var m var
NB.+scheme: var?
NB.+example: var 3
NB.-This predicate test whether y is of type integer and is not a vector.\

NB.*get d get
NB.+scheme: find
NB.+example: (_.;'a') get 1
NB.-Walks the state x to find the substitution of y.\
NB.-Tests whether the position y in x is `<_.`.
NB.-If `<_.` is found or the verb fails, y is returned.
NB.-Otherwise the y-th element is returned.
NB.-Walking the state is done by executing until the result stops changing.

NB.*occ d occ
NB.+scheme: occurs?
NB.+example: (<2) occ <<2
NB.-Tests x & y for identity, and returns zero in that case. If x & y are different, we flatten the tree y to a list of leaves and check for x membership in the flattened tree.

NB.*ext d ext
NB.+scheme: ext-s
NB.+example: (<_.) ext 0;'a'
NB.-Replaces the values of y by their substitutions according to x, and stores that in a. 
NB.-For unification to occur, the pair must 
NB.-1.pass the occurs check and 
NB.-2.the substituted values must be either identical to themselves (i.e. fresh variables) or identical to the values pointed to in the substitution. 
NB.-Unification then occurs by amending the positions pointed to in x by those in a.

NB.*uni c uni
NB.+scheme: unify
NB.+example: (_ _) 0 uni 'a' (<_.)
NB.-We test u & v for identity, and return the substitution y unchanged if true.
NB.-We then check that all variables in the terms to be unified are in scope by flattening the tree and comparing to the length of y.
NB.-Rank polymorphism is then achieved by splitting the terms according to the desired left and right ranks given in x.
NB.-We map the tree in paths to obtain a list of paths, and then filter the variable paths into vp.
NB.-Substitution paths are obtained in vs by negating the first element of each variable path. 
NB.-We check that all substitution paths are present in the paths in fp by checking for membership in all prefixes of the path list.
NB.-We rearrange into 2 columns with variables on the left, and values to be unified on the right.
NB.-Rows of the table t are then filtered to eliminate identical values and cycles in ft.
NB.-Finally, the state is updated.

NB.*equ c equ
NB.+scheme: ==
NB.+example: 0 equ 'a' (<_.)
NB.-The equivalence constraint. u and v are values to be unified. y is the state array.
NB.-All constraints must define an optional default rank in x.

NB.*fsh a fsh
NB.+scheme: call/fresh
NB.+example: ] fsh ''
NB.-Introduces a new variable by extending the state array y with an indeterminate value. 

NB.*app d app
NB.+scheme: $append
NB.-Test x, and if a promise makes a new promise with reversed arguments (line 4). 
NB.-Otherwise appends and recurs (line 5). The depth of recursion is usually not too great, so it seems ok.

NB.*apm c apm
NB.+scheme: $append-map
NB.-Works similarly to app. apm is a conjunction only because it has to handle functions as arguments.

NB.*dis c dis
NB.+scheme: disj
NB.-Disjunction.

NB.*con c con
NB.+scheme: conj
NB.-Conjunction.

NB.*cis c cis
NB.+scheme: call/initial-state
NB.-Notice the initial state is a boxed indeterminate value, in our case.
NB.-We 'fold' over the initial promise a user-defined number of times. Since this actually does not map over a sequence but only produces one as we go, this is more akin to a loop.
