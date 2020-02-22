NB. vars are integers
var =: e.&1 4@(3!:0)*.-.@#@$

NB.FIND====================================
(0 : 0)
- arrays are ATOMIC (so no problem with null)
- x can only be a SINGLE lvar
)
find =: ([`(]$:~]{::~>:@(0&{::@]i.[))@.(e.0&{::@]))`[@.(-:&''@[)

NB.OCCURS====================================
(0 : 0)
-essentially checks wether a variable is present in branch nodes (not root)
-u is always an lvar, so atomic
-walk for any lvar in tree
QUESTION: should we walk for u too??
)
occurs =: 2 : 0
 if. u = v
  do. 0 return.
 end.
 +./ (0:`(u = y find~ ])@.var S:0) v
)

NB.EXTS====================================
(0 : 0)
-u is ATOMIC
)
exts =: 2 : 0
 (u&,&.>@{.,((<v),}.))`0:@.(u occurs v) y
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

NB.UNIFY====================================
(0 : 0)
0.u & v: check if same shape
1.u & v: check if leaf is variable
2.u & v: get paths to those leaves that are variables (<S:1){::
3.u & v: extend state for those leaves if occurs check succeeds
)

unify=:2 : 0
 if. ($u)~:($v)
  do. 0 return.
 elseif. u -: v
  do. y return.
 end.
 paths=.(<S:1){::(u;<v)
 vars=.(var S:0)(u;<v)
)

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


