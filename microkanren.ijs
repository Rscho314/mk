var =: (4 1 e.~ 3!:0) *. -.@#@$
get =: ({::~^:(-.@(128!:5)@{::~)^:(var@]) :: ]) ^: _

NB.occ =: 4 : '+./ (0:`((x {::~ ;~0) -: y&get)@.var"0 _) S: 0 x {::~ 0;1'

NB.ext =: 4 : 0
NB. x =. ((< y i. {:@> x) 1} ])^:((# y) > y i. {:) &.> x
NB. (({: > x) (x {::~ ;~ 0) } ])`_1:@.(x&occ) y
NB.)

NB.uni =: 2 : 0
NB. tree =. y&get &.> (u;<v)
NB. if. -:/ tree do. y return. end.
NB. vp =. (1&-:@((#y)&>^:var)S:0 # (<S:1)@{::) tree
NB. vs =. (-.&.>@{. 0}])&.> vp
NB. 'vs ss' =. (#~~:@:(}. &.>))~ &.> (vs e. ,@(<\ S: 1)@{::tree)&# &.> (vp;<vs)
NB. if. (2&> +. {:@#:) # vs,ss do. _1 return. end.
NB. y ext F.. ] _2 <\ ]@{::&tree &.> vs,@,.ss
NB.)

occ =: 4 : 0
 +./ (>x)&-: S:0 y
)

NB. CONTINUE HERE
ext =: 4 : 0
 y =. x&get &.> y
 NB.echo y
 NB.echo ({:y),:~((#x)&= x i. {: y) } (;/x i. {: y) ,: ({.y)
 y =. ({:y),:~((#x)&= x i. {: y) } (;/x i. {: y) ,: ({.y)
 if. +./ occ"0/ y do. _1 return. end.
 ({: y) (0 {:: y) } x
)
(0;1;2) uni ('a';'b';'c') (_. ; _. ; 'c')
(0;1;2) uni ('a';0;'c') (_. ; _. ; 'c')
(0;1;2) uni ('a';1;'c') (_. ; _. ; 'c')
(0;1;2) uni ('a';'a';'c') (_. ; _. ; 'c')
(0;1;2) uni ('a';2;'c') (_. ; _. ; 'c')
(0;1;2) uni ('a';'b';'c') (_. ; _. ; 'd')

uni =: 2 : 0
 tree =. y&get &.> (u;<v)
 if. -:/ tree do. y return. end.
 vp =. (1&-:@((#y)&>^:var)S:0 # (<S:1)@{::) tree
 vs =. (-.&.>@{. 0}])&.> vp
 'vs ss' =. (#~~:@:(}. &.>))~ &.> (vs e. ,@(<\ S: 1)@{::tree)&# &.> (vp;<vs)
 if. (2&> +. {:@#:) # vs,ss do. _1 return. end.
 y ext (tree{::~]) &.> vs,:ss
)

equ =: 2 : '<(y get u) uni (y get v) y'
fsh =: 1 : 'u (<_.) ,~ y'

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , ((5!:5)<'a') , ')'''')' [ a =.0{::x
 elseif. do. ({.x) , (}.x) app y
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :' , ((5!:5)<'a') , ')'''') apm (' , ((5!:5)<'v') , ')' [ a =.0{::u
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'
pul =: (".@>)^:(0:`(2&=@(3!:0)@>)@.(1 = #))

tak =: 4 : 0
 acc =. ''
 while. (x > 0) *. (y -.@-: '')
  do. 'x y acc' =. (<: x);(pul@{: y);<(acc,~{.y)
 end.
 acc
)

cis =: 2 : 'u tak (pul@v (<_.))'

NB.(6!:2 , 7!:2) '10000 cis fives_and_sixes' NB.reference
NB.(6!:2 , 7!:2) '10000 cis fivesit' NB.3 - 10X faster with 1/2 the memory
