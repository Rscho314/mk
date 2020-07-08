var =: -.@#@$*.e.&4 1@(3!:0)
get =: {::~^:(var@])"(_ 0)^:_
occ =: (e. < S: 0)`0:@.-:

ext =: 4 : 0
while. 1
 do.
  y =. x&get L:0 y NB.grounding ensures further checks are consistent with prior state
  y =. ~. (#~ (i.@# < i.&1"1@(-:"1/ |."1)~))~ y NB.permutations and repeated or twin pairs
  if. '' -: y do. x return. end.
  isvar =. > var &.> y
  if. +./ (occ/"1 y) , (+:/"1 isvar) do. _1 return. end. NB.occurs check & discordant pairs
  candidates =. (*:/"1 isvar) # y {"1~ |."1 isvar NB.var-value pairs, var on left
  if. '' -.@-: , candidates
   do.
    x =. ({:"1 candidates) (>@{."1 candidates) } x
    y =. y -. candidates
  else. break.
  end.
end.
NB.perform cycle elimination!
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
 NB.check if residual values are inside a substitution
 if. -. *./ ((-.~ prefix_paths)~ residual_paths) e. prefix_paths substpaths
 NB.if not inside a substitution, check if non-identical and if so, fail.
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
 x (y get u) uni (y get v) y
)

ini =: ''
fsh =: ,<@#

NB.app =: 4 : 0
NB. if. x -: ''
NB.  do. y
NB. elseif. 2&=@(3!:0)@> x
NB.  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , (quote 0 {:: x) , ')'''')'
NB. elseif. do. ({. , (y app~ }.)) x
NB. end.
NB.)

NB.apm =: 2 : 0
NB. if. u -: ''
NB.  do. ''
NB. elseif. 2&=@(3!:0)@> u
NB.  do. < '((3 :' , (quote@> u) , ')'''') apm (' , ((5!:5)<'v') , ')'
NB. elseif. do. (v (>u)) app (}.u) apm v
NB. end.
NB.)

NB.dis =: 2 : '(u y) app (v y)'
NB.con =: 2 : '(u y) apm v'

NB.run =: 2 : 0
NB. if. u > 1
NB.  do. 'initval initprom' =. v y
NB.      runhlp =. (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)
NB.      initval ; ground &.> runhlp F: {. _ ; initprom ; < <: u
NB. elseif. u = 1 do. {. v y
NB. elseif. u = 0 do. ''
NB. elseif. do. _1
NB. end.
NB. :
NB. if. u > 1
NB.  do. 'initval initprom' =. v y
NB.      runhlp =. (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)
NB.      (x&{ &.> initval) ; (x&{@ground &.>) runhlp F: {. _ ; initprom ; < <: u
NB. elseif. u = 1 do. {. v y
NB. elseif. u = 0 do. ''
NB. elseif. do. _1
NB. end.
NB.)

NB.4 run peano ini NB.OK
NB.(0) 4 run fives_and_sixes '' NB.OK
NB.(0) 4 run peano '' NB.OK

NB.(0 15 25 ,. 2 6 10) upro (ini 2}]) &.> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB.fails, OK
NB.here, grounding should fail & yield the variable! An easy workaround: initialize variables in subst to themselves instead of _.
NB.(0 15 25 ,. 2 6 10) bpro (ini 2}]) &.> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB._. should be '2'
NB.(0 15 25 ,. 2 6 10) upro (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB.OK
NB.(0 15 25 ,. 2 6 10) bpro (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB.OK
NB.26 27 upro (1 0) (4 5 6 10 ,: 7 8 9 12) equ (26 27) 2&fsh@> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB.OK
NB.26 27 bpro (1 0) (4 5 6 10 ,: 7 8 9 12) equ (26 27) 2&fsh@> (0 0) (i. 26) equ (a. {~ 97 + i. 26) 26 fsh '' NB.OK

NB.0 upro 5 run fives_and_sixes ini NB.OK
NB.1 upro 5 run fives_and_sixes ini NB.OK
NB.0 bpro 5 run fives_and_sixes ini NB.OK
NB.1 bpro 5 run fives_and_sixes ini NB.OK
NB.(0) 5 run fives_and_sixes '' NB.OK
NB.(1) 5 run fives_and_sixes '' NB.fails, OK

NB.start_jpm_''
NB.10 cis peano
NB.showtotal_jpm_''
