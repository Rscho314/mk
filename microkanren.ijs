var =: (4 1 e.~ 3!:0) *. -.@#@$

get =: (([:^:(128!:5))@{::~^:(var@:]) :: ]) ^: _

NB.(_. ; _. ; 3 ; 4 ; 'a') ( ((] {:: (,<))^:(#@[ > ])^:(var@])) ) 2

occ =: 4 : 0
 if. x -: y do. 0 return. end.
 x e. < S:0 y
)

ext =: 4 : 0
 if. -:/ y do. x return. end.
 a =. x&get L:0 y
 if. (occ"0/ a) +. (*./ ({.y) = {.a) +: (+./ -:"0/ a) do. _1 return. end.
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

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , (quote 0{:: x) , ')'''')'
 elseif. do. ({.x) , y app~ }.x
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :' , (quote 0{:: u) , ')'''') apm (' , ((5!:5)<'v') , ')'
 elseif. do. (v 0 {:: u) app (}.u) apm v
 end.
)

dis =: 2 : '(u y) app (v y)'

con =: 2 : '(u y) apm v'

cishlp =: 3 : 0
 _2 Z: -. * _1 {:: y
 (". 1 {:: y) , <: &.> {: y
)

cis =: 2 : 0
 'initval initprom' =. v <_.
 initval ; cishlp F: {. (_ ; initprom ; < <: u)
)

NB.load'jpm'
NB.start_jpm_''
NB.1000 cis peano
NB.10000 cis fives_and_sixes
NB.showtotal_jpm_''
NB.showdetail_jpm_'ext'
NB.showdetail_jpm_'cishlp'
NB.showdetail_jpm_'app'
NB.showdetail_jpm_'apm'
