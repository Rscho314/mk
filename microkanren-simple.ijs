load'format/printf'
var =: -.@#@$*.e.&4 1@(3!:0)
get =: {::~^:(var@])"(_ 0)^:_
occ =: 2 : 0
 if. var v do. u -: v
 elseif. 32&=@(3!:0) v
  do.  +./ ; u&e. &.> ((< S:0) , (<@(y&get) S:0)) v
  NB.do. (u occ (y get 0&{:: v) y) +. (u occ (y get }. v) y)
 elseif. do. 0
 end.
)

ext =: 2 : 0
 if. u occ v y do. _1
 else. (<v) u } y
 end.
)

uni =: 2 : 0
 (_ _) u uni v y
:
 'u v' =. (,<"({.x) u) ;< ,<"({:x) v
 if. u -: v do. y
 elseif. var@> u do. (>u) ext (>v) y
 elseif. var@> v do. (0 _) (>v) uni (>u) y
 elseif. (>&1@# u) *. >&1@# v NB.[ qprintf 'u v y ' NB.pair definition is inconsistent!
  do. x (y get }. >u) uni (y get }. >v) x (y get 0&{:: >u) uni (y get 0&{:: >v) y
 elseif. do. _2
 end.
)
(<0) uni (<1) fsh^:2 ''
(_ _) (0;1) uni (2;3) fsh^:4 ''
(0 0) (0;1) uni (2;3) fsh^:4 ''
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

0 equ 0 fsh ''
0 equ 1 fsh^:2 ''
(_ _) (0;1) equ (2;3) fsh^:4 ''
0 equ 'a' fsh ''
'a' equ 1 fsh^:2 ''
(_ 0) ('a';'b') equ 1 fsh^:2 ''
0 equ (<0) fsh ''