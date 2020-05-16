var =: (4 1 e.~ 3!:0) *. -.@#@$
get =: (([:^:(128!:5))@{::~^:(var@:]) :: ]) ^: _
occ =: (e. < S: 0)`0:@.-:

ext =: 4 : 0
 a =. x&get L:0 y
 if. 1&e. occ/"1 a do. _1 return. end.
 ({:"1 y) (0&{::"1 y) } x
)

NB. boxed/unboxed cases must be treated separately
uni =: 2 : 0
 if. u -: v do. y return. end.  NB.identity check
 'chku chkv' =. ,@(0:`((#y)&<:)@.var)"0 S:0 &.> u ;< v NB.scope check
 if. +./ chku , chkv do. 'error: variable out-of-scope' return. end.
 NB.reshape on rank
 'lr rr' =. x
 u =. , <"lr u
 v =. , <"rr v
 if. (#u) ~: #v do. 'error: incompatible shape' return. end.
 NB.remove from ext input 1.if = by col 2.if = by row 3.if = by reversed row
 ft =. (((_2%~#) {. ~:)@(|."1 , ]) # ]) ~. (u ~: v)&# u ,. v
 if. 1&e. +:/"1 var@> ft do. _1 return. end. NB.@ this point, if pair of values they don't unify
 y ext (\:"1 var@> ft) {"1 ft
)

NB.(_ _) (,2)uni(,2) (3#<_.)
NB.(1 0) (27 3 $ a. { ~ 35 + i. 81) uni (i. 27) 27 # <_.
NB.(<0) uni (<1) (2#<_.)

NB.(_ _) ('a' ; < < ('c' ; 0)) uni ('b' ; < < (1 ; 'd')) (_. ; _.)
NB.(_ _) 0 uni (3 3 3 3 $ >: i. 81) 82 # <_.
NB.(1 1) (27 3 $ a. { ~ 35 + i. 81) uni (3 3 3 3 $ i. 81) 81 # <_.
NB.(1 1) (27 3 $ ;/ a. { ~ 35 + i. 81) uni (3 3 3 3 $ ;/ i. 81) 81 # <_.
NB.(1 0) (27 3 $ a. { ~ 35 + i. 81) uni (;/ i. 27) 27 # <_.
NB.0 uni (3 3 3 3 $ >: i.81) 82 # <_.

(0 : 0)
We could probably make a special case where this
(3 3 3 $ ;/ a. {~ 97+i.27) equ (3 3 3 $ ;/ i.27) 27#<_.
could be done unboxed like this
(3 3 3 $ a. {~ 97+i.27) equ (3 3 3 $ i.27) 27#<_.
since 'if.' testing for 32&=@(3!:0) on u & v returning 0
means that the terms a) are not nested b) are of uniform type
so we could make a special code path for it.
)

equ =: 2 : 0
 if. -. x do. x =. _ _ else. end.
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