require'format/printf'

var =: 4&=@(3!:0)*.-.@#@$
find =: ]`(>:@(0&{::@[i.]){::([,<@]))@.(var@])^:_
occurs =: 4 : '+./ (((0;0){::x) -: y find ]) S: 0 (0;1){::x'
exts =: 4 : 0
 if. x occurs y do. 0 return. end.
 ((,&((0;0){::x) &.>@{.y) 0} y) , < ((0;1){::x)
)

unify =: 2 : 0
 tree =. u ;< v
 vars =. var S: 0 tree
 if. u -: v do. y return. elseif. -. +./ vars do. 0 return. end.
 paths =. (< S: 1) {:: tree
 varsubst =. ~. (] ,@,. ((-.&.>@{. 0}])&.>)) paths {~ I. vars
 if. -. *./ varsubst e. paths do. 0 return. end.
 y exts F.. ] _2 <\ (tree {::~ ]) &.> varsubst
)


NB.CALLFRESH====================================
(0 : 0)
looks at shape of term to be unified
-(term call state) constraint term (term fresh state)
-term call constraint fresh state
-state constraint callfresh term
-callfresh constraint term state
-state constraint"0 term
last is probably best as it allows to choose rank easily
and callfresh would always be there anyway, so useless
conclusion:
-call & fresh can be made separate
-will not appear @ top level, but inside constraints
problem:
-is it possible for call&fresh to inherit the rank of
the top level constraint?
)