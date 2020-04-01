load'format/printf'
est =: < 2
var =: 4&=@(3!:0) *. -.@#@$
get =: (>:@(}.@(0 {:: [) i. ]) {:: ([@, <))^:(var@])^:_
occ =: 4 : '+./ ((x {::~ ;~0) -: y&get) S: 0 x {::~ 0;1'

ext =: 4 : 0
 x =. < ]`(<@(y {::~ 0&;@>:@((}. y)&i.)))@.(((}.y) e.~ ])"0) (>x)
 if. (('';0)&{:: -: ('';1)&{::) x do. y return. end.
 x ((0;<<<0)&{::@[ ,~ ((] , (;~0)&{::@[) &.> {.) 0} ])`0:@.(occ) y
)

uni =: 2 : 0
 if. u -: v do. y return. end.
 vp =. (I.@((0:`((y{::~;~0)&>)@.var)S:0){(<S:1)@{::) (u;<v)
 if. vp -: '' do. 0 return. end.
 vs =. ~. (] ,@,. (-.&.>@{. 0}])&.>) vp
 if. vs -.@(*./)@e. ,@(<\ S: 1)@{:: (u;<v) do. 0 return. end.
 y ext F.. ] _2 <\ ]@{::&(u;<v) &.> vs
)

NB.2 uni ('a';'b') (4 3;<('a';'b'))
NB.2 equ ('a';'b') fsh est
NB.('a';3) uni (2;'b') (<4)
NB.2 equ ('a') fsh est
NB.2 equ ('') fsh est
NB.2 equ ('a';2) fsh est

equ =: 2 : '<(y get u) uni (y get v) y'
fsh =: 1 : 'u ((>:@{. , }.) &.> {. y) 0} y'

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :''' , (0 {:: x) , ''')'''')'
 elseif. do. ({.x) , (}.x) app y
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :''' , (0 {:: u) , ''')'''') apm (' , ((5!:5)<'v') , ')'
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'
pul =: (".@>)^:(0:`(2&=@(3!:0)@>)@.(1 = #))
tak =: ({.@] , (<:@[ $: pul@{:@]))`{.@.(''&-:@] +. 0&-:@<:@[)
cis =: 2 : 'u tak pul v est'

fives =: 3 : 0
 ((,5) equ (y {::~ ;~0) fsh) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
)
fives est
3 cis fives

peano =: 3 : 0
 ((y {::~ ;~0) equ 'z') dis (((<:@((0;0)&{::)y) equ ('s' ; (y {::~ ;~0))) con (3 : '<''peano ('',((5!:5)<''y''),'')''') fsh) fsh y
)
NB.peano est
NB.2 cis peano
