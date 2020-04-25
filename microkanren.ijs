var =: 0:`(0&<:)@.((4 1 e.~ 3!:0) *. -.@#@$)
get =: ({::~^:(-.@(128!:5)@{::~)^:(var@]) :: ]) ^: _
occ =: 4 : '+./ (0:`((x {::~ ;~0) -: y&get)@.var"0 _) S: 0 x {::~ 0;1'
ext =: 4 : 0
 x =. ((< y i. {:@> x) 1} ])^:((# y) > y i. {:) &.> x
 (({: > x) (x {::~ ;~ 0) } ])`_1:@.(x&occ) y
)

uni =: 2 : 0
 tree =. y&get &.> (u;<v)
 vp =. (I.@(1&-:@((#y)&>^:var) S: 0) { (<S:1)@{::) tree
 if. -:/ tree do. y return. end.
 s =. (-.&.>@{. 0}])&.> vp
 vs =. (0&{:: ,@,. 1&{::) ({~I.@~:@:(}. &.>))~ &.> (I. s e. ,@(<\ S: 1)@{::tree)&{ &.> (vp;<s)
 if. (2&> +. {:@#:) # vs do. _1 return. end.
 y ext F.. ] _2 <\ ]@{::&tree &.> vs
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

appit =: 2 : 0
 while. u -.@-: ''
   do.if. 2&=@(3!:0)@> u
       do. < '(' , ((5!:5)<'v') , ') appit (3 :' , ((5!:5)<'a') , ')(', ((5!:5)<'y') ,')' [ a =.0{::u
      else. 'u y' =. (}.u);(y,~<@{.u)
      end.
 end.
 y
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
disit =: 2 : '(u y) appit (v y) '''' '
con =: 2 : '(u y) apm v'
pul =: (".@>)^:(0:`(2&=@(3!:0)@>)@.(1 = #))
tak =: ({.@] , (<:@[ $: pul@{:@]))`{.@.(''&-:@] +. 0&-:@<:@[)
cis =: 2 : 'u tak pul v (<_.)'

fivesit =: 3 : 0
 ((,5) equ (<:#y)) disit (3 : '<''fivesit ('' , ((5!:5) <''y'') , '')''') y
)
sixesit =: 3 : 0
 ((,6) equ (<:#y)) disit (3 : '<''sixesit ('' , ((5!:5) <''y'') , '')''') y
)
fives_and_sixesit =: 3 :'fivesit disit sixesit y'
10 cis fives_and_sixesit

fives =: 3 : 0
 ((,5) equ (<:#y)) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
)
(6!:2 , 7!:2) '1000 cis fives' NB.reference
(6!:2 , 7!:2) '1000 cis fivesit' NB.This is 10X faster with 1/2 the memory!