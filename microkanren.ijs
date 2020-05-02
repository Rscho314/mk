var =: (4 1 e.~ 3!:0) *. -.@#@$

get =: ({::~^:(-.@(128!:5)@{::~)^:(var@]) :: ]) ^: _

occ =: 4 : 0
 if. x -: y do. 0 return. end.
 x e. < S:0 ;/y
)

ext =: 4 : 0
 if. -:/ y do. x return. end.
 a =. x&get L:0 y
 if. (+./ occ"0/ a) +. (-. *./ (({:a)&= +. ({.y)&=) x&get &.> {.y) do. _1 return. end.
  ({: a) (0 {:: y) } ,x
)

uni =: 2 : 0
 tree =. (u;<v)
 if. -:/ tree do. y return. end.
 vp =. (1&-:@((#y)&>^:var)S:0 # (<S:1)@{::) tree
 vs =. (-.&.>@{. 0}])&.> vp
 'vs ss' =. (#~~:@:(}. &.>))~ &.> (vs e. ,@(<\ S: 1)@{::tree)&# &.> (vp;<vs)
 if. (2&> +. {:@#:) # vs,ss do. _1 return. end.
 y ext (tree{::~]) &.> vs,:ss
)

equ =: 2 : '<(y get u) uni (y get v) y'

fsh =: 1 : 'u (<_.) ,~ y'

promise =: 3 :'0 < +./ 0:`((4!:0 :: 0) S: 1)@.(1 = #) y'

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. promise > x
  do. <(<(<,'0'),<y) ; (,<'app') ;< (<(<,'0'),<((_1 {:: x)`:6))
 elseif. do. ({.x) , (}.x) app y
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. promise > u
  do. <(<(<,'0'),<((_1 {:: u)`:6)) ; (,<'app') ;< (<(<,'0'),<v)
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

dis =: 2 : '(u y) app (v y)'

con =: 2 : '(u y) apm v'

pul =: 3 : 0
 if. promise y
  do. (> y)`:6
 else. y
 end.
)

tak =: 4 : 0
 acc =. ''
 while. (x > 0) *. (y -.@-: '')
  do. 'x y acc' =. (<: x);(pul {: y);<(acc,~{.y)
 end.
 acc
)

cis =: 2 : 'u tak pul v <_.'