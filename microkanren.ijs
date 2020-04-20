load'format/printf'
var =: 0:`(0&<:)@.(e.&4 1@(3!:0) *. -.@#@$)
get =: ]`(([ {::~ ])^:(-.@(128!:5)@([ {::~ ]))^:(#@[ > ]))@.(var@])^:_
occ =: 4 : '+./ (0:`((x {::~ ;~0) -: y&get)@.var"0 _) S: 0 x {::~ 0;1'

ext =: 4 : 0
 x =. ((< y i. {:@> x) 1} ])^:((# y) > y i. {:) &.> x
 (({: > x) (x {::~ ;~ 0) } ])`_1:@.(x&occ) y
)

uni =: 2 : 0
 vp =. (I.@((0:`((var@(y&get))`_1:@.((<:#y)&I.))@.var)S:0){(<S:1)@{::) (u;<v)
 'u v' =. y&get &.> (u;<v)
 if. u -: v do. y return. end.
 if. vp -: '' do. _1 return. end.
 vs =. ~. (] ,@,. (-.&.>@{. 0}])&.>) vp
 if. vs -.@(*./)@e. ,@(<\ S: 1)@{:: (u;<v) do. _1 return. end.
 y ext F.. ] _2 <\ ]@{::&(u;<v) &.> vs
)
NB.0 uni (1;'b') (_. ; _.) Fails due to 'uni' algorthm (test_uni_subtree_var)

equ =: 2 : '<(y get u) uni (y get v) y'
fsh =: 1 : 'u (<_.) ,~ y'

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :''' , (0 {:: x) , ''')'''')' NB.problem here!
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
cis =: 2 : 'u tak pul v '''' '

NB.6 cis fives_and_sixes

NB.fives =: 3 : 0
NB. ((,5) equ (#y) fsh) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
NB.)
NB.fives ''
NB.3 cis fives

NB.peano =: 3 : 0
NB. ((y {::~ ;~0) equ 'z') dis (((<:@((0;0)&{::)y) equ ('s' ; (y {::~ ;~0))) con (3 : '<''peano ('',((5!:5)<''y''),'')''') fsh) fsh y
NB.)
NB.peano est
NB.2 cis peano
