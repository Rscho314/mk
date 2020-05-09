var =: (4 1 e.~ 3!:0) *. -.@#@$
get =: (([:^:(128!:5))@{::~^:(var@:]) :: ]) ^: _

occ =: 4 : 0
 if. x -: y do. 0 return. end.
 x e. < S:0 y
)

ext =: 4 : 0
 if. -:/ y do. x return. end.
 a =. x&get L:0 y
 if. 1 (e. ,) (-.@-:)`occ@.(var@>@[)"0/ a do. _1 return. end.
 ({: a) (0 {:: y) } ,x
)

uni =: 2 : 0
 tree =. (u;<v)
 if. -:/ tree do. y return. end.
 vp =. (1&-:@((#y)&>^:var)S:0 # (<S:1)@{::) tree
 vs =. (-.&.>@{. 0}])&.> vp
 'vs ss' =. (#~~:@:(}. &.>))~ &.> (vs (e. ,) (<\ S: 1) {::tree)&# &.> (vp;<vs)
 if. (2&> +. {:@#:) # vs,ss do. _1 return. end.
 y ext (tree{::~]) &.> vs,:ss
)

equ =: 2 : '<(y get u) uni (y get v) y'
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
