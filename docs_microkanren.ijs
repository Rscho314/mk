NB.%microkanren.ijs - an attempt at an array kanren
NB.-This script is an attempt at a mostly verbatim implementation of [scheme microkanren](https://github.com/jasonhemann/microKanren-DLS-16).\
NB.-
NB.-* Trees are represented by nested boxed arrays.\
NB.-* Variables are integers and are considered in scope if lying between zero and the length of the state array.\
NB.-* Promises are boxed strings, and are forced by the *execute* verb (`".`).\
NB.-* The indeterminate value (`_.`) was chosen as initial value in the state array because of its limited usefulness in the J language, and to allow unification with the empty array (`''`). `_.` is therefore a marker of freshness of a variable.
NB.-
NB.-**CAUTION: there certainly are major bugs and misunderstandings in this, due to my inexpertise in both logic and J!**

NB.*var m var
NB.+scheme: var?
NB.+example: var 3
NB.-This predicate test whether 1.the type is integer and 2.is not a vector.\

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
NB.-Begins by flattening the y tree y, and checks for membership of x into the flattened list of boxes.

NB.*ext d ext
NB.+scheme: ext-s
NB.+example: (<_.) ext 0;'a'
NB.-If the pair of variables/values y to be unified holds identical elements, returns x immediately without change (line 1). 
NB.-Replaces the values of y by their substitutions according to x, and stores that in a (line 2). 
NB.-For unification to occur, the pair must 
NB.-1.pass the occurs check and 
NB.-2.the substituted values must be either identical to themselves (i.e. fresh variables) or identical to the values pointed to in the substitution (line 3). 
NB.-Unification then occurs by amending the positions pointed to in x by those in a. Of course, we should be able to do better than this circlejerk in the future.

NB.*uni c uni
NB.+scheme: unify
NB.+example: 0 uni 'a' (<_.)
NB.+bugs: 0 uni 1 (_.;0)
NB.-A tree is formed by combining u and v, for convenience (line 1). y is the state array. 
NB.-The two main branches are compared and we return immediately if they are found identical (line 2). 
NB.-The variable paths in the tree are then extracted in vp, by flattening the tree to a list of paths and filtering this list for variables not in scope, which are simply dropped with no error handling (line 3). 
NB.-Substitution paths are obtained in vs by negating the first element of each variable path (line 4). 
NB.-The tree of variable/substitution path is filtered for 1.substitution paths not lying in the initial tree by testing against all prefixes of the initial tree paths. 
NB.-This covers cases such as 0 uni (1;'a') (`_.;_.`) that would fail otherwise. 2. we eliminate paths differing only by their forst element to avoid failure in cases such as (0 uni 1 (`_.;0`)) (line 5). 
NB.-The variable/substitution tree is then checked for parity and non-emptiness (line 6). 
NB.-Finally, the state is updated by mapping the newly built paths into the original tree (line 7).

NB.*equ c equ
NB.+scheme: ==
NB.+example: 0 equ 'a' (<_.)
NB.-The equivalence constraint. u and v are values to be unified. y is the state array.

NB.*fsh a fsh
NB.+scheme: call/fresh
NB.+example: ] fsh ''
NB.-Introduces a new variable by extending the state array y with an indeterminate value. 

NB.*app d app
NB.+scheme: $append
NB.-Test x, and if a promise makes a new promise with reversed arguments (line 4). 
NB.-Otherwise appends and recurs (line 5). The depth of recursion is not too great, so it seems ok.

NB.*apm c apm
NB.+scheme: $append-map
NB.-Works similarly to app. apm is a conjunction because it has to handle functions as arguments.

NB.*dis c dis
NB.+scheme: disj
NB.-Disjunction.

NB.*con c con
NB.+scheme: conj
NB.-Conjunction.

NB.*pul m pul
NB.+scheme: pull
NB.-Test if y is a promise, and executes if that is the case. Otherwise, yields 0.

NB.*tak d tak
NB.+scheme: take
NB.-Transformed to the iterative form, since J does not have recursion facilities such as tail-call elimination (divides space complexity by ~3).

NB.*cis c cis
NB.+scheme: call/initial-state
NB.-Notice the initial state is a boxed indeterminate value, in our case.
