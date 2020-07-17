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
runhelper =: (".@(1&{::) , (<: &.>@{:)) [ _2&Z:@-.@*@(2&{::)

run =: 2 : 0
 if. u > 1
  do. 'initval initprom' =. v y
      initval ; ground &.> runhelper F: {. _ ; initprom ; < <: u
 elseif. u = 1 do. {. v y
 elseif. u = 0 do. ''
 elseif. do. _1
 end.
:
 if. u > 1
  do. 'initval initprom' =. v y
      (x&{ &.> initval) ; (x&{@ground &.>) runhelper F: {. _ ; initprom ; < <: u
 elseif. u = 1 do. {. v y
 elseif. u = 0 do. ''
 elseif. do. _1
 end.
)

bpro =: 4 : '(>y)&get L:0 x&{ > y'
upro =: 4 : '((>y)&get L:0)@> x&{ > y'
ini =: ''

NB.Performance testing for the paper =============================================
peano =: 3 : 0
(3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''')@fsh) y
)

floats =: (3 : '(0 0) y uni (i. # y) fsh^:(#y) '''' ')

unicode =: 3 : '(0 0) (i. y) equ (u: i. y) fsh^:y ini'

as =: 3 : '(0 0) ((<''a'') , ;/ i. <: y) uni (;/ i. y) (;/ i. y)'

load 'plot'
plot_ts_peano =: 4 : 0
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

floats_perf =: 3 : 0
 n =. */\ 4 #~ y
 data =. (?@#&0) &.> ;/ n
 t =. (x:!.0)(6!:2)@> 'floats '&,@":@(?@#&0) &.> ;/ n
 ct =. _ , */\ (x:2) %~/\ ; t
 st =. _ , (x:2) %~/\ ; t
 legend =. 'N';'time [s]';'cumulative time ratio';'step time ratio' NB. ;'space [bytes]';'cumulative space ratio';'step space ratio'
 legend , <"0 n ,. t ,. ct ,. st
)
NB.floats_perf 7

peano_perf =: 3 : 0
 n =. */\ 4 #~ y
 t =. (x:!.0) (6!:2)@> (' run peano fsh ''''',~":) &.> ;/ n
 ct =. _ , */\ (x:2) %~/\ ; t
 st =. _ , (x:2) %~/\ ; t
 legend =. 'N';'time [s]';'cumulative time ratio';'step time ratio' NB. ;'space [bytes]';'cumulative space ratio';'step space ratio'
 legend , <"0 n ,. t ,. ct ,. st
)
NB.peano_perf 6

as_perf =: 3 : 0
 n =. */\ 4 #~ y
 t =. (x:!.0) (6!:2)@> ('as ' , ":) &.> ;/ n
 ct =. _ , */\ (x:2) %~/\ ; t
 st =. _ , (x:2) %~/\ ; t
 legend =. 'N';'time [s]';'cumulative time ratio';'step time ratio' NB. ;'space [bytes]';'cumulative space ratio';'step space ratio'
 legend , <"0 n ,. t ,. ct ,. st
)
NB.as_perf 6
