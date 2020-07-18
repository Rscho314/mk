var =: -.@#@$*.e.&4 1@(3!:0)
get =: {::~^:(var@])"(_ 0)^:_
occ =: (e. < S: 0)`0:@.-:

ext =: 4 : 0
while. 1
 do.
  y =. x&get L:0 y
  y =. ~. (#~ (i.@# < i.&1"1@(-:"1/ |."1)~))~ y
  if. '' -: y do. x return. end.
  isvar =. > var &.> y
  if. +./ (occ/"1 y) , (+:/"1 isvar) do. _1 return. end.
  candidates =. (*:/"1 isvar) # y {"1~ |."1 isvar
  if. '' -.@-: , candidates
   do.
    x =. ({:"1 candidates) (>@{."1 candidates) } x
    y =. y -. candidates
  else. break.
  end.
end.
if. '' -.@-: , y do. ({:"1 y) (>@{."1 y) } x  else. x end. NB.insert remaining free vars
)

uni =: 2 : 0
 (_ _) u uni v y
:
 u =. , <"({.x) u
 v =. , <"({:x) v
 if. (#u) ~: #v do. _1 return. end.
 tree =. u;<v
 paths =. (<S:1)@{:: tree
 varpaths_candidates =. paths #~ var S:0 tree
 substpaths_candidates =. ((-. &.>@{.) 0} ]) &.> varpaths_candidates
 prefix_paths =. ;@:(,@(<\) &.>)
 subst_exists =. e.&(prefix_paths paths) substpaths_candidates
 'varpaths substpaths' =. subst_exists&# &.> varpaths_candidates ;< substpaths_candidates
 residual_paths =. paths -. varpaths , substpaths
 if. -. *./ ((-.~ prefix_paths)~ residual_paths) e. prefix_paths substpaths
  do. if. (0 = 2&|) # {::&tree &.> residual_paths
       do. if. ~:/ ($~ (2,-:@#))~ {::&tree &.> residual_paths do. _1 return. end.
      else. _1 return.
      end.
 end.
 y ext {::&tree L:1 varpaths ,. substpaths
)

equ =: 2 : 0
 (_ _) u equ v y
:
 < x (y get u) uni (y get v) y
)

fsh =: ,<@#
prom =: 2&=@(3!:0)@>

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. prom x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , (quote 0 {:: x) , ')'''')'
 elseif. do. ({. , (y app~ }.)) x
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. prom u
  do. < '((3 :' , (quote@> u) , ')'''') apm (' , ((5!:5)<'v') , ')'
 elseif. do. (v (>u)) app (}.u) apm v
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'
ground =: 3 : '(y&get L:0)^:_ y'

run =: 2 : 0
 a: u run v y
:
 (x&{@ground &.>@}:@((}: , ".@(_1&{::))^:((u&>:*.1&<)@#)^:_ )@v@fsh) ^: (u > #) y
)

bpro =: 4 : '(>y)&get L:0 x&{ > y'
upro =: 4 : '((>y)&get L:0)@> x&{ > y'
