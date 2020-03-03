var =: 4&=@(3!:0)*.-.@#@$
find =: ]`(>:@(0&{::@[i.]){::([,<@]))@.(var@])^:_
occurs =: 4 : '+./ (((0;0){::x) -: y find ]) S: 0 (0;1){::x'
exts =: ({:@>@[ ,~ ((],((0;0)&{::)@[) &.> {.@]) 0} ])`0:@.(occurs)
unify =: 2 : 0
 tree =. u ;< v
 vars =. var S: 0 tree
 if. u -: v do. y return. elseif. -. +./ vars do. 0 return. end.
 paths =. (< S: 1) {:: tree
 varsubst =. ~. (] ,@,. ((-.&.>@{. 0}])&.>)) paths {~ I. vars
 if. -. *./ varsubst e. paths do. 0 return. end.
 y exts F.. ] _2 <\ (tree {::~ ]) &.> varsubst
)

eq =: 4 : 0
 vbl =. 0 {:: y
 cnt =. 1 { y
 stt =. {: y
 uni =. (stt find x) unify (stt find vbl) stt
 if. uni
  do. < cnt , uni
 else. (<'')
 end.
)

cf =: 1 : 'u ({.,(>:@] &.> {.@] 0} ])) y'

append =: 2 : 0 NB.seek to make this non-recursive! Should this be an adverb?
 if. u -: ''
  do. v
 elseif. 3&=@(4!:0) <'u'
  do. 3 : '(' , ((5!:5)<'v') , ') append ((' , ((5!:5)<'u') , ')'''')'
 elseif. do. ({. u) , ((}. u) append v)
 end.
)

disj =: 2 : '(u y) append (v y)'



(0 : 0)
-Now, it is impractical to use a variable directly with eq, but since
eq is now a verb it will be easier to write goal combinators such as
disj and conj.
-cf should probably be an adverb
-use the 'x'=.y trick!
-Also, maybe there is the opportunity for inverted tables, since the
1st (counter) & 2nd (variables) cells of goals all are the same type.

('z'&eq cf) disj ('sz'&eq cf) 2;''
)
