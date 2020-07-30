0 : 0
Arithmetic - using '0' & '1' should be possible since vars cannot be vectors!
)

var =: -.@#@$*.e.&4 1@(3!:0)
get =: {::~^:(var@])"(_ 0)^:_ NB.get value. Make another 'get-root-var' function?
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

uni =: 2 : 0
 (_ _) u uni v y
:
 tree =. (,<"({.x) u) ;< ,<"({:x) v
 if. ~:/ # &.> tree do. _1 return. end.
 paths =. (< S: 1)@{:: tree
NB.path partitioning
 varc =. paths #~ var S: 0 tree
 subc =. ((-. &.>@{.) 0} ]) &.> varc
 sube =. e.&(;@:(<\ &.>) paths) subc
 'varp subp' =. sube&# &.> varc ;< subc
 resp =. varp -.~ (#~ -.@;@:(+./@,@(subp&=@<\) &.>))~ paths
NB.residual paths check (empty or symmetric)
 if. +./@:~:/@($~ 2&,@-:@#)~ {::&tree &.> resp do. _1 return. end.
NB.unification proper (better to start by appending to y to avoid get??)
 eqclc =. ((</.)~ (>.~ (|.~ -:@#)~)~@(-@>:@i.@# >. ;@:((-@_:^:(-.@var))@({::&tree) &.>)))~ varp,subp
 eqclc =. (#~ 1&<@#@>)~ ~. &.> (<"1@(,.~ <"0@i.@#)~ y) , {::&tree L:1 eqclc NB.no get! Now fuse on var
 eqclcvars =. (#~ var@>)~ &.> eqclc
 eqcl =. (-.@>&1@(+/) # <@I.) (+: >/~@i.@~.@$)~ ;"1 *./@~: &.> (<@;@,"0/~) eqclcvars
 /:~@~.@;@:{&eqclc &.> eqcl
 NB.check no more than 1 value per equivalence class!
 NB.replace all vars not at the top level by their equivalence class, then occurs check?
)
(0 0)(0;'a';2;'b';3;5;'';6;7;(< 'a'; 3)) uni (1;1;'c';'b';4;5;'';'';'a';8) (<2) 3} fsh^:9 ''

(1 0) (3 2 $ a.{~65+i.6) uni (i.3) fsh^:3 ''
(0 0)(0;<1;2) uni ('a';<'b';'c') fsh^:3 ''
(_ _)(0;<1;2) uni ('a';<'b';'c') fsh^:3 ''

(0;<1;'c';'d') uni ('a';<'b';'c';'d') fsh^:2 ''
(0;<'a';2) uni (1;<1;'c') fsh^:3 ''
(0;<'a';2;'b';3) uni (1;<1;'c';'b';4) fsh^:5 ''
(0;<'a';2;'b';3;5) uni (1;<1;'c';'b';4;5) fsh^:6 ''
(0;<'a';2;'b';3;5;'') uni (1;<1;'c';'b';4;5;'') fsh^:6 ''
(0;<'a';2;'b';3;5;'';6) uni (1;<1;'c';'b';4;5;'';'') fsh^:7 ''

(0 0)(0;'a';2;'b';3;5;'';6;7;(< 'a'; 3)) uni (1;1;'c';'b';4;5;'';'';'a';8) fsh^:9 ''
(_ _)(0;'a';2;'b';3;5;'';6;7;(< 'a'; 3)) uni (1;1;'c';'b';4;5;'';'';'a';8) fsh^:9 ''
(0 0)(0;'a';2;'b';3;5;'d';6;7;(< 'a'; 3)) uni (1;1;'c';'b';4;5;'e';'';'a';8) fsh^:9 ''
NB.(unify '(0 #\a 2 #\b 3 5 () 6 7 (#\a 3)) '(1 1 #\c #\b 4 5 () () #\a 8) '())

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
