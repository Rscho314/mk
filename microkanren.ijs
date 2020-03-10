require'format/printf'

var =: 4&=@(3!:0)*.-.@#@$
find =: ]`(>:@(1&{::@[i.]){::(}.@[,<@]))@.(var@])^:_
occurs =: 4 : '+./ (((0;0){::x) -: y find ]) S: 0 (0;1){::x'

exts =: 4 : 0
 'a b' =. y&find &.> > x
 if. a -: b do. y return. end.
 if. (<a) e. (2 }. y) do. a =. y {::~ 1 ; (2 }. y) i. (<a) end.
 if. (<b) e. (2 }. y) do. b =. y {::~ 1 ; (2 }. y) i. (<b) end.
 (<a;b) ({:@>@[ ,~ ((],((0;0)&{::)@[) &.> 1&{@]) 1} ])`0:@.(occurs) y
)

unify =: 2 : 0
 scope =. }. ; 2 {. y
 tree =. u ;< v
 vars =. (0:`(e.&scope)@.var) S: 0 tree
 if. u -: v do. y return. elseif. -. +./ vars do. 0 return. end.
 paths =. (< S: 1) {:: tree
 varsubst =. ~. (] ,@,. ((-.&.>@{. 0}])&.>)) paths {~ I. vars
 if. -. *./ varsubst e. paths do. 0 return. end.
 y exts F.. ] _2 <\ (tree {::~ ]) &.> varsubst
)

eq =: 2 : 0
 uni =. (y find u) unify (y find v) y
 if. uni
  do. < uni NB.to change to account for variables that have just been fused!
 else. < y NB.to change to account for variables that have just been fused!
 end.
)

cf =: 3 : '((>:@{.,({.,}.)) &.>@{. 0} ]) y'

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
-space inefficiency -> implement path compression in 'exts' or 'unify'
-make a dyadic version of cf to generate several variables at once
-Also, maybe there is the opportunity for inverted tables, since the
1st (counter) & 2nd (variables) cells of goals all are the same type.


('z' eq 2) disj ('sz' eq 2) cf 2;''
('z' eq 2) conj ((3 eq 2)@cf) (cf 2;'') NB.still problem!
('z' eq 2) conj ((2 eq 3)@cf) (cf 2;'')

s/c structure
-------------
-box   0: car is counter, cdr is list of fresh lvars
-box   1: list of fused variables
-box >=2: boxes containing fused values

)
