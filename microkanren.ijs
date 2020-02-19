NB. vars are integers, or arrays of integers
var =: (4&=+.1&=)@(3!:0)

NB.FIND====================================
(0 : 0)
- works for both scalars & arrays, by using rank 0
- will only be used on tree leaves, i.e. non-boxed atoms/arrays
- yields a substituted result of the same shape as x
- substitutions must have a uniform type, otherwise heterogeneous array->error

PROBLEM:
(1 2) find (0;(2;1);<('';3.5))
)
find =:([`((]$:~]{::~2;<@[i.~1&{::@]) :: [)@.(var@[))"(0 _)


NB.OCCURS====================================
(0 : 0)
-essentially checks wether a variable (boxed int)
can be found at any depth in a nested boxed array that is
to be unified with said variable.
-u is always a leaf, so non-boxed atom/vector
0 -> does not occur
1 -> occurs
)

occurs=:2 : 0
u;v;y
 idx =. I.;var&.>,u
 if. ''-:idx
  do. 0 return.
 end.
 vinu =. idx{,u
 flattensubst =. <@(y find~])S:0 &.> idx{,v
 foundvar =. ;var@(y find~])&.>(idx{,v)
 varintree =. vinu (e.>)"0 flattensubst
 +./(0 1)&-:"1 foundvar,.varintree
)


occurs=:2 : 0
u;v;y
 if. -.var u
  do. 0 return.
 elseif. ($u)-.@-:($v)
  do. 0 return.
 end.
  
)
NB.(2 3) occurs (2;<<3) (0;'';'')

NB.EXTS====================================
(0 : 0)
-improvement: make 'exts' also work on non-boxed terms
)
exts =: 2 : '((((1&{::y),,u);<((2&{::y),,v)) 1 2}])`0:@.(u occurs v) y'

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


