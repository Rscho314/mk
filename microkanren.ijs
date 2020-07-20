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

NB. EQUIVALENCE CLASSES
uni =: 2 : 0
 (_ _) u uni v y
:
 if. (#u) ~: #v do. _1 return. end.
 tree =. (,<"({.x) u) ;< ,<"({:x) v
 paths =. (<S:1)@{:: tree
 eqcl =. paths (</.)~ ((-:@# |. ]) >. ]) (-@>:@i.@#paths) >. (-@_:^:(-.@var)) S:0 tree
 (/:~)@~. &.> ({::&tree) L:1 eqcl NB.eq class root => first, value => last
 NB.vars =. (>:@i.@# paths) * var S:0 tree NB.distinct value to each var occurence
 NB.subs =. (-:@# |. ]) vars NB.now vars & subst have same marker
 NB.(vars <. subs) ]/. paths NB.use /. to group
 NB.(vars <. subs) NB.this is the problem to solve to make equivalence classes
)
(1 0) (3 2 $ a.{~65+i.6) uni (i.3) fsh^:3 ''
(0;<1;2) uni ('a';<'b';'c') fsh^:3 ''
(0;<1;'c';'d') uni ('a';<'b';'c';'d') fsh^:2 ''
(0;<'a';2) uni (1;<1;'c') fsh^:3 '' NB.needs further processing

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
 x&{@ground &.> ((]`(}:@((}: , ".@(_1&{::))^:(u >:#)^:_))@. (prom@{:))@v@fsh) ^: (u > #) y
)

bpro =: 4 : '(>y)&get L:0 x&{ > y'
upro =: 4 : '((>y)&get L:0)@> x&{ > y'
