var =: (4 1 e.~ 3!:0) *. -.@#@$
get =: (([:^:(128!:5))"(_ 0)@({::~^:(var@]))"(_ 0) :: ])^: _
occ =: (e. < S: 0)`0:@.-:

ext =: 4 : 0
 a =. x&get L:0 y
 if. 1&e. (occ/"1 a) , (~:/"1 a)&*. +:/@;"1 var &.> a do. _1 return. end.
 ({:"1 y) (0&{::"1 y) } x
)

uni =: 2 : 0
 if. u -: v do. y return. end.
 'chku chkv' =. ,@(0:`((#y)&<:)@.var)"0 S:0 &.> u;<v
 if. +./ chku , chkv do. _1 return. end.
 'lr rr' =. x
 u =. , <"lr u
 v =. , <"rr v
 if. (#u) ~: #v do. _1 return. end.
 tree =. u;<v
 paths =. (<S:1)@{:: tree
 vp =. paths #~ var S:0 tree
 sp =. ((-. &.>@{.) 0} ]) &.> vp
 fp =. sp e. ; <\ &.> paths
 if. -. +./ fp do. _1 return. end.
 t =. ~. {::&tree L:1 fp # vp ,. sp
 ft =. ((i."1&1 > i.@{.@$)@(<"1 -:"0/ <"1@|."1) # ]) (~:/"1 # ]) t
 if. 1&e. +:/"1 var@> ft do. _1 return. end.
 y&ext (\:"1 var@> ft) {"1 ft
)

equ =: 2 : 0
 (_ _) u equ v y
:
 < x (y get u) uni (y get v) y
)

fsh =: (3 : 'y , < _.') : (4 : 'y , x # < _.')

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , (quote 0 {:: x) , ')'''')'
 elseif. do. ({. , (y app~ }.)) x
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :' , (quote@> u) , ')'''') apm (' , ((5!:5)<'v') , ')'
 elseif. do. (v (>u)) app (}.u) apm v
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'

cis =: 2 : 0
 'initval initprom' =. v <_.
 cishlp =. (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)
 initval ; cishlp F: {. _ ; initprom ; < <: u
)

NB. SYNTAX SUGAR=======================================================
bpro =: 4 : '<"0@(x get~ ]) &.> y' NB.must enhance to reify subtrees & reject out-of-scope!
upro =: 4 : '(x get~ ]) &.> y' NB.must enhance to reify subtrees & reject out-of-scope!
run =: 2 : 0
 'box runs vars' =. u
 if. box
  do. vars bpro runs cis v
 else. vars upro runs cis v
 end.
)

(0 : 0)
perhaps a dyadic form of cis could be used for run variable scoping instead of (u/b)pro??
)

NB.(0 15 25 ,. 2 6 10) upro (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh ''
NB.(0 15 25 ,. 2 6 10) bpro (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh ''
NB.26 27 upro (1 0) (4 5 6 10 ,: 7 8 9 12) equ (26 27) 2&fsh@> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh ''
NB.26 27 bpro (1 0) (4 5 6 10 ,: 7 8 9 12) equ (26 27) 2&fsh@> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh ''

NB.(0 4 0) run peano NB.INCOMPLETE, does not reify subtrees!
NB.(0 5 0) run fives_and_sixes NB.OK
NB.(1 5 0) run fives_and_sixes NB.OK
NB.(1 5 1) run fives_and_sixes NB.WRONG, out-of-scope
NB.0 upro 5 cis fives_and_sixes NB.OK
NB.1 upro 5 cis fives_and_sixes NB.WRONG, out-of-scope

NB.start_jpm_''
NB.10 cis peano
NB.showtotal_jpm_''