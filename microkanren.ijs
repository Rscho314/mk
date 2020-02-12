NB. vars are boxed nats
var =: ((1&=+.4&=)@(3!:0)@>*.32&=@(3!:0))`0:@.((<'')&-: +. ''&-:)
NB. 1st cell = counter, state is an associative array
find =: ([`((([i.~1&{::@]){2&{::@])$:])@.(var@[) :: [)
occurs =: 4 : '+./ x e. (1&{::,2&{::) y'
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
+/@,@var a NB.lvar count
-.@*@(+/)@,@var a NB.ground term?
(var a) *. (var b) NB.var-var unify, candidates for walk
(var a) +. (var b) NB.all unify candidates
(var a) ~: (var b) NB.var-term unify candidates


unify =: 2 : 0
NB.PROBLEM: unify <-> occurs wrong! (test_unify_bnat_bnat)
 a =. y
 if. (u&-:+.v&-:) ''
  do. 0 return. NB.#f equivalent, does not unify
 elseif. (32&=@(3!:0) u) *: (32&=@(3!:0) v)
  do. 0 return. NB.unification only on boxes
 elseif. ($u)-.@-:($v)
  do. 0 return. NB.different shape, does not unify
 elseif. u -: v
  do. y return.
 end.
 if. +/@,@var u
  do. if. (({~I.@,@var)~u) occurs a
       do. 0 return. NB.lvar occurs
      else. a =. ((({~I.@var)~@,u) exts ((,v){~I.@,@var u) a)
      end.
 end.
 if. +/@,@var v
  do. if. (({~I.@,@var)~v) occurs a NB.use the maybe extended state
       do. 0 return.
      else. a =. ((({~I.@var)~@,v) exts ((,u){~I.@,@var v) a)
      end.
 end.
 if. -.@*@(+/)@,(var u),(var v)
  do. 0 return. NB.no lvars in u & v, does not unify
 end.
 a
)


