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

tak =: 2 : 0
 while. (u > 0) *. (v -.@-: '')
  do. 'u v y' =. (<: u);(pul@{: v);<(y,~{.v)
 end.
 y
)

cis =: 2 : 'u tak (pul@v (<_.)) '''' '

NB.(6!:2 , 7!:2) '10000 cis fives' NB.reference
NB.(6!:2 , 7!:2) '10000 cisit fives' NB.marginally faster, but 1/3 - 1/4 mermory
NB.(6!:2 , 7!:2) '10000 cis fivesit' NB.3 - 10X faster with 1/2 the memory
NB.(6!:2 , 7!:2) '10000 cisit fivesit' NB.This is 3 - 10X faster with 1/25 the memory!