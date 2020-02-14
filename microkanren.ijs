NB.The lib is defined only on boxed arrays
NB. vars are ints
var =: ((4&=+.1&=)@(3!:0)*.0&=@#@$)
NB. 1st cell = counter, state is an associative array
find =: ([`(((<@[i.~1&{::@]){::2&{::@])$:])@.(var@[) :: [)

NB.OCCURS====================================
(0 : 0)
-essentially checks wether a variable (boxed int)
can be found at any depth in a nested boxed array that is
to be unified with said variable.
-currently wrong bc occurs fails on unification with self (X-:X)
correction:
1.a:walk the state. b:check if var
2.independently, member in flattened substitution
result:
var&member->1
notvar&member->0
notvar&notmember->1
var&notmember->1
)
occurs=:2 : 0
 idx =. I.;var&.>,u
 vinu =. idx{,u
 flattensubst =. y (4 :'(<S:0)&.>(x find~])L:0 y') idx{,v
 *./vinu (e.>)"0 flattensubst
)
(<1) occurs (<2) (0;(<2);<<1)

a=.'a';0;'b';1;2;3 4
b=. 9;0;'c';(<7);(<<6;5);'de'
s=. (0;(7;8;2);<((<1);10;'r'))
a occurs b s

NB.EXTS====================================
(0 : 0)

)
exts =: 2 : '((((1&{::y),,u);<((2&{::y),,v)) 1 2}])`0:@.((,u,v)&occurs) y'

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

NB.UNIFY====================================
a =: 'a';1;2;<''
b =: 3;'b';'c';<4
NB. unify builds up state, that's all!
(var a) NB.where are the lvars
+/@,@var a NB.lvar count3
-.@*@(+/)@,@var a NB.ground term?
(var a) *. (var b) NB.var-var unify, candidates for walk
(var a) +. (var b) NB.all unify candidates
(var a) ~: (var b) NB.var-term unify candidates



unify =: 2 : 0
 a =. y
 if. (u&-:+.v&-:) ''
  do. 0 return.
 elseif. u -: v
  do. y return.
 elseif. (32&=@(3!:0) u) *: (32&=@(3!:0) v)
  do. 0 return.
 elseif. ($u)-.@-:($v)
  do. 0 return.
 elseif. -.@*@(+/)@,(var u),(var v)
  do. 0 return.
 end.
 if. +/@,@var u
  do. a =. ((({~I.@var)~@,u) exts ((,v){~I.@,@var u) a)
 end.
 if. +/@,@var v
  do. a =. ((({~I.@var)~@,v) exts ((,u){~I.@,@var v) a)
 end.
 a
)


