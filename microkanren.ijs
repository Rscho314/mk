require'format/printf'

var =: 4&=@(3!:0)*.-.@#@$
find =: ]`(>:@(}.@(0&{::)@[i.]){::([,<@]))@.(var@])^:_
occurs =: 4 : '+./ (((0;0){::x) -: y find ]) S: 0 (0;1){::x'

exts =: 4 : 0
 'a b' =. y&find &.> > x
 if. a -: b do. y return. end.
 if. (<a) e. (}. y) do. a =. y {::~ 0 ; >: (}. y) i. (<a) end.
 if. (<b) e. (}. y) do. b =. y {::~ 0 ; >: (}. y) i. (<b) end.
 (<a;b) ({:@>@[ ,~ ((],((0;0)&{::)@[) &.> {.@]) 0} ])`0:@.(occurs) y
)

unify =: 2 : 0
 inscope =. ((0;0) {:: y) > ]
 tree =. u ;< v
 vars =. (0:`inscope@.var) S: 0 tree
 if. u -: v do. y return. elseif. -. +./ vars do. 0 return. end.
 paths =. (< S: 1) {:: tree
 varsubst =. ~. (] ,@,. ((-.&.>@{. 0}])&.>)) paths {~ I. vars
 if. -. *./ varsubst e. paths do. 0 return. end.
 y exts F.. ] _2 <\ (tree {::~ ]) &.> varsubst
)

eq =: 2 : '<(y find u) unify (y find v) y'

cf =: 1 : 'u ((>:@{.,}.) &.> {. y) 0} y'

app =: 2 : 0 NB.seek to make this non-recursive!
 if. u -: ''
  do. v
 elseif. 3&=@(4!:0) <'u'
  do. 3 : '(' , ((5!:5)<'v') , ') app ((' , ((5!:5)<'u') , ')'''')'
 elseif. do. ({.u) , ((}.u) app v)
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 3&=@(4!:0) <'u'
  do. 3 : '((' , ((5!:5)<'u') , ')'''')apm(' , ((5!:5)<'v') , ')'
 elseif. do. (v (0 {:: u)) app ((}.u) apm v)
 end.
)

disj =: 2 : '(u y) app (v y)'
conj =: 2 : '(u y) apm v'


(0 : 0)
-make a dyadic version of cf to generate several variables at once
-Also, maybe there is the opportunity for inverted tables, since the
1st (counter) & 2nd (variables) cells of goals all are the same type.

('sz' eq 2) cf (<2)
('z' eq 2 cf) disj ('sz' eq 2 cf)  (<2)
(('z' eq 2) disj ('sz' eq 2)) cf (<2)
(('z' eq 2) conj ((3 eq 2) cf)) cf (<2)

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
