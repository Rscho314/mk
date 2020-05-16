var =: (4 1 e.~ 3!:0) *. -.@#@$
get =: (([:^:(128!:5))@{::~^:(var@:]) :: ]) ^: _
occ =: (e. < S: 0)`0:@.-:

ext =: 4 : 0
 a =. x&get L:0 y
 if. 1&e. (occ/"1 a) , (~:/"1 a)&*. +:/@;"1 var &.> a do. _1 return. end.
 ({:"1 y) (0&{::"1 y) } x
)

uni =: 2 : 0
 if. u -: v do. y return. end.  NB.identity check
 'chku chkv' =. ,@(0:`((#y)&<:)@.var)"0 S:0 &.> u ;< v NB.scope check
 if. +./ chku , chkv do. 'error: variable out-of-scope' return. end.
 NB.reshape on rank
 'lr rr' =. x
 u =. , <"lr u
 v =. , <"rr v
 if. (#u) ~: #v do. 'error: incompatible shape' return. end.
 paths =. (<S:1)@{:: u ;< v NB.now unify with rank 0 0
 vsp =. var S:0 u ;< v
 vp =. vsp # paths
 sp =. ((-. &.>@{.) 0} ]) &.> vp
 fp =. sp e. ; <\ &.> paths
 if. -. +./ fp do. _1 return. end.
 t =. ~. {::&(u;<v) L:1 fp # vp ,. sp
 NB.remove from ext input 1.if = by col 2.if = by row 3.if = by reversed row
 ft =. ((i."1&1 > i.@{.@$)@(<"1 -:"0/ <"1@|."1) # ]) (~:/"1 # ]) t NB.should this really not create cycles?
 if. 1&e. +:/"1 var@> ft do. _1 return. end. NB.@ this point, if pair of values they don't unify
 y&ext (\:"1 var@> ft) {"1 ft
)

equ =: 2 : 0
 < (_ _) (y get u) uni (y get v) y
:
 < x (y get u) uni (y get v) y
)

fsh =: 1 : 'u (<_.) ,~ y'

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
 cishlp =. (3 : '(". 1 {:: y) , <: &.> {: y [ _2 Z: -. * 2 {:: y')
 initval ; cishlp F: {. _ ; initprom ; < <: u
)