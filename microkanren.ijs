require'format/printf'

var =: 4&=@(3!:0)*.-.@#@$
find =: ]`(>:@(0&{::@[i.]){::([,<@]))@.(var@])^:_
occurs =: 2 : '+./ ((y find u) -: y find ]) S:0 v'
exts =: 2 : '((u,>@{.);((<v),}.))`]@.(u occurs v) y'
recextshlp=: 4 :'(0&{::x) exts (1&{::x) y'
recexts=: (2&}.@[ $: ([ recextshlp ]))`]@.(''-:[)

unify =: 2 : 0
 if. u -: v
  do. y return.
 end.
 isvar =. (var S:0) (u;<v)
 if. -.+./ isvar
  do. 0 return.
 end.
 paths =. (<S:1) {:: (u;<v)
 varpaths =. paths {~ I. isvar
 substpaths =. ((-.&.>@{.),}.)&.>varpaths
 filtered =. *./+./ paths =/ substpaths
 if. -. filtered
  do. 0 return.
 end.
 vars =. ((u;<v){::~]) &.> varpaths
 subst =. ((u;<v){::~]) &.> substpaths
 (,vars,.subst) recexts y
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