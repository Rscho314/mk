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
 < x (y get u) uni (y get v) y
)

ini =: ''
fsh =: ,<@#

app =: 4 : 0
 if. x -: ''
  do. y
 elseif. 2&=@(3!:0)@> x
  do. < '(' , ((5!:5)<'y') , ') app ((3 :' , (quote 0 {:: x) , ')'''')'
 elseif. do. ({. , (y app~ }.)) x
 end.
)

apm =: 2 : 0
 if. u -: ''
  do. ''
 elseif. 2&=@(3!:0)@> u
  do. < '((3 :' , (quote@> u) , ')'''') apm (' , ((5!:5)<'v') , ')'
 elseif. do. (v (>u)) app (}.u) apm v
 end.
)

dis =: 2 : '(u y) app (v y)'
con =: 2 : '(u y) apm v'

ground =: 3 : '(y&get L:0)^:_ y'

run =: 2 : 0
 if. u > 1
  do. 'initval initprom' =. v y
      runhlp =. (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)
      initval ; ground &.> runhlp F: {. _ ; initprom ; < <: u
 elseif. u = 1 do. {. v y
 elseif. u = 0 do. ''
 elseif. do. _1
 end.
:
 if. u > 1
  do. 'initval initprom' =. v y
      runhlp =. (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)
      (x&{ &.> initval) ; (x&{@ground &.>) runhlp F: {. _ ; initprom ; < <: u
 elseif. u = 1 do. {. v y
 elseif. u = 0 do. ''
 elseif. do. _1
 end.
)

bpro =: 4 : '(>y)&get L:0 x&{ > y'
upro =: 4 : '((>y)&get L:0)@> x&{ > y'

NB.Performance testing for the paper =============================================

peano =: 3 : 0
 (3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''')@fsh) y
)

load 'plot'
plot_ts =: 4 : 0
 factor =. */\ (1 {:: y) # 2
 pd 'reset'
 pd 'type line'
 pd 'color 0 0 0'
 pd 'titlefont Calibri 18'
 pd 'captionfont Calibri 12'
 pd 'title Peano Number Sequence Generation Time'
 pd 'xcaption maximal number in sequence [n]'
 pd 'ycaption execution time (ratio to n = 2)'
 pd (}. factor) ; */\ (x:2) %~/\ ; ((0{::y)!:2) &.>  <"1 (' run peano fsh ini' ,~ ":)"0 factor
 pd 'pdf ' , x , ' 400 400'
)
NB.'/home/raoul/Desktop/mk_paper/time.pdf' plot_ts (6 ; 5)
NB.'/home/raoul/Desktop/mk_paper/time.pdf' plot_ts (7 ; 5)

table_perf =: 3 : 0 NB.almost immediate up to y = 5. y = 8 is already >2 mins!
 factor =. */\ y # 2
 t =. (x:!.0) ; (6!:2) &.>  <"1 (' run peano fsh ini' ,~ ":)"0 factor
 ct =. _ , */\ (x:2) %~/\ ; t
 st =. _ , (x:2) %~/\ ; t
 s =. (x:!.0) ; (7!:2) &.>  <"1 (' run peano fsh ini' ,~ ":)"0 factor
 cs =. _ , */\ (x:2) %~/\ ; s
 ss =. _ , (x:2) %~/\ ; s
 legend =. 'N';'time [s]';'cumulative time ratio';'step time ratio';'space [bytes]';'cumulative space ratio';'step space ratio'
 legend , <"0 factor ,. t ,. ct ,. st ,. s ,. cs ,. ss
)