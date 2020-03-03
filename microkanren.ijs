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
 vbl =. 0 {:: x
 cnt =. 1 { x
 stt =. 2 }. x
 uni =. (stt find y) unify (stt find vbl) stt
 if. uni
  do. < cnt , uni
 else. (<'')
 end.
)

cf =: {. , (>:@] &.> {.@] 0} ])

NB.(cf 2;'') eq 'a' NB.starts @ 2 bc 0 & 1 are values, not variables!

(0 : 0)
Now, it is impractical to use a variable directly with eq, but since
eq is now a verb it will be easier to write goal combinators such as
disj and conj.

Also, maybe there is the opportunity for inverted tables, since the
1st (counter) & 2nd (variables) cells of goals all are the same type.
)
