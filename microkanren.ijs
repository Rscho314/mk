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
var =: (4 1 e.~ 3!:0) *. -.@#@$

NB.*get d get
NB.+scheme: find
NB.+example: (_.;'a') get 1
NB.-Walks the state x to find the substitution of y.\
NB.-Tests whether the position y in x is `<_.`.
NB.-If `<_.` is found or the verb fails, y is returned.
NB.-Otherwise the y-th element is returned.
NB.-Walking the state is done by executing until the result stops changing.
get =: ({::~^:(-.@(128!:5)@{::~)^:(var@]) :: ]) ^: _

NB.*occ d occ
NB.+scheme: occurs?
NB.+example: (<2) occ <<2
NB.-Begins by flattening the y tree y, and checks for membership of x into the flattened list of boxes.
occ =: 4 : 0
 if. x -: y do. 0 return. end.
 x e. < S:0 ;/y
)

NB.*ext d ext
NB.+scheme: ext-s
NB.+example: (<_.) ext 0;'a'
NB.-If the pair of variables/values y to be unified holds identical elements, returns x immediately without change (line 1). 
NB.-Replaces the values of y by their substitutions according to x, and stores that in a (line 2). 
NB.-For unification to occur, the pair must 
NB.-1.pass the occurs check and 
NB.-2.the substituted values must be either identical to themselves (i.e. fresh variables) or identical to the values pointed to in the substitution (line 3). 
NB.-Unification then occurs by amending the positions pointed to in x by those in a. Of course, we should be able to do better than this circlejerk in the future.
ext =: 4 : 0
 if. -:/ y do. x return. end.
 a =. x&get L:0 y
 if. (+./ occ"0/ a) +. (-. *./ (({:a)&= +. ({.y)&=) x&get &.> {.y) do. _1 return. end.
  ({: a) (0 {:: y) } ,x
)

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
uni =: 2 : 0
 tree =. (u;<v)
 if. -:/ tree do. y return. end.
 vp =. (1&-:@((#y)&>^:var)S:0 # (<S:1)@{::) tree
 vs =. (-.&.>@{. 0}])&.> vp
 'vs ss' =. (#~~:@:(}. &.>))~ &.> (vs e. ,@(<\ S: 1)@{::tree)&# &.> (vp;<vs)
 if. (2&> +. {:@#:) # vs,ss do. _1 return. end.
 y ext (tree{::~]) &.> vs,:ss
)

NB.*equ c equ
NB.+scheme: ==
NB.+example: 0 equ 'a' (<_.)
NB.-The equivalence constraint. u and v are values to be unified. y is the state array.
equ =: 2 : '<(y get u) uni (y get v) y'

NB.*fsh a fsh
NB.+scheme: call/fresh
NB.+example: ] fsh ''
NB.-Introduces a new variable by extending the state array y with an indeterminate value. 
fsh =: 1 : 'u (<_.) ,~ y'

NB.*app d app
NB.+scheme: $append
NB.-Test x, and if a promise makes a new promise with reversed arguments (line 4). 
NB.-Otherwise appends and recurs (line 5). The depth of recursion is not too great, so it seems ok.
app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , ((5!:5)<'a') , ')'''')' [ a =.0{::x
 elseif. do. ({.x) , (}.x) app y
 end.
)

NB.*apm c apm
NB.+scheme: $append-map
NB.-Works similarly to app. apm is a conjunction because it has to handle functions as arguments.
apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :' , ((5!:5)<'a') , ')'''') apm (' , ((5!:5)<'v') , ')' [ a =.0{::u
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

NB.*dis c dis
NB.+scheme: disj
NB.-Disjunction.
dis =: 2 : '(u y) app (v y)'

NB.*con c con
NB.+scheme: conj
NB.-Conjunction.
con =: 2 : '(u y) apm v'

NB.*pul m pul
NB.+scheme: pull
NB.-Test if y is a promise, and executes if that is the case. Otherwise, yields 0.
pul =: (".@>)^:(0:`(2&=@(3!:0)@>)@.(1 = #))

NB.*tak d tak
NB.+scheme: take
NB.-Transformed to the iterative form, since J does not have recursion facilities such as tail-call elimination (divides space complexity by ~3).
tak =: 4 : 0
 acc =. ''
 while. (x > 0) *. (y -.@-: '')
  do. 'x y acc' =. (<: x);(pul@{: y);<(acc,~{.y)
 end.
 acc
)

NB.*cis c cis
NB.+scheme: call/initial-state
NB.-Notice the initial state is a boxed indeterminate value, in our case.
cis =: 2 : 'u tak (pul@v (<_.))'
