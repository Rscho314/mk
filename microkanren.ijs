require'format/printf'
est =: < 2
var =: 4&=@(3!:0) *. -.@#@$
get =: ]`(>:@(}.@(0 {:: [) i. ]) {:: ([@, <))@.(var@])^:_
occ =: 4 : '+./ ((x {::~ ;~0) -: y&get) S: 0 x {::~ 0;1'

ext =: 4 : 0
 'a b' =. y&get &.> > x
 if. a -: b do. y return. end.
 a =. (y {::~ 0&;@>:@((}. y) i. <))^:(e.&(}. y)@<) a
 b =. (y {::~ 0&;@>:@((}. y) i. <))^:(e.&(}. y)@<) b
 (<a;b) ((0;<<<0)&{::@[ ,~ ((] , (;~0)&{::@[) &.> {.) 0} ])`0:@.(occ) y
)

uni =: 2 : 0
 inscope =. (y {::~ ;~0) > ]
 tree =. u ;< v
 vars =. (0:`inscope@.var) S: 0 tree
 if. u -: v do. y return. elseif. -. +./ vars do. 0 return. end.
 paths =. (< S: 1) {:: tree
 varsubst =. ~. (] ,@,. ((-.&.>@{. 0}])&.>)) paths {~ I. vars
 if. -. *./ varsubst e. paths do. 0 return. end.
 y ext F.. ] _2 <\ ]@{::&tree &.> varsubst
)

equ =: 2 : '<(y get u) uni (y get v) y'
fsh =: 1 : 'u ((>:@{. , }.) &.> {. y) 0} y'

app =: 4 : 0 NB.seek to make this non-recursive!
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. <'(' , ((5!:5)<'y') , ') app ((' , '3 :''' , (0 {:: x) , ''')'''')'
 elseif. do. ({.x) , (}.x) app y
 end.
)

apm =: 4 : 0
 if. x -: ''
  do. ''
 elseif. 2&=@(3!:0)@> x
  do. 'no cigar'
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'

pull =: 3 : 0
 if. 2&=@(3!:0)@> y
  do. pull (3 : (0 {:: y)) ''
 else. y
 end.
)

take =: 4 : 0
 if. '' -: y
  do. ''
 elseif. 0&-: <: x
  do. {. y
 elseif. do. ({. y) , (<: x) take (pull {: y)
 end.
)

fives =: 3 : '((,5) equ (y {::~ ;~0) fsh) dis (3 : ''<''''fives ('''' , ((5!:5) <''''y'''') , '''')'''''') y'
sixes =: 3 : '((,6) equ (y {::~ ;~0) fsh) dis (3 : ''<''''sixes ('''' , ((5!:5) <''''y'''') , '''')'''''') y'
fives_and_sixes =: 3 : 'fives dis sixes y'
6 take fives est NB.take all would be _ take (fives <2) -> non-termination
4 take sixes est
fives_and_sixes est
6 take fives_and_sixes est

(0 : 0)
-make a dyadic version of cf to generate several variables at once
-Also, maybe there is the opportunity for inverted tables, since the
1st (counter) & 2nd (variables) cells of goals all are the same type.

tests:
------
('sz' equ 2) fsh est
('z' equ 2 fsh) dis ('sz' equ 2 fsh)  est
(('z' equ 2) dis ('sz' equ 2)) fsh est
(('z' equ 2) con ((3 equ 2) fsh)) fsh est

s/c structure
-------------
-box   0: car is counter, cdr is list of fused lvars
-box >=1: boxes containing fused values
-empty s/c is (<2)

scoping
-------
-cf increments the counter
-lvars in scope are those [2 .. (counter - 1)]. Should be ok since lang is pure?
-a lvar in scope but not fused is considered fresh.
-test for freshness of lvar? -> 'find' it. If this returns itself (not found), it's fresh!
)
