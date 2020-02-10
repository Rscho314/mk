NB. vars are boxed nats
var =: ((1&=+.4&=)@(3!:0)@>*.32&=@(3!:0))`0:@.((<'')&-: +. ''&-:)
NB. 1st cell = counter, state is an associative array
find =: ([`((([i.~1&{::@]){2&{::@])$:])@.(var@[) :: [)
exts =: 2 : '(((1&{::y),u);<((2&{::y),v)) 1 2}y'
occurs =: 4 : 'x e. (1&{::,2&{::) y'

NB.UNIFY====================================
a =: 'a';1;2;<''
b =: 3;'b';'c';<4
NB. unify builds up state, that's all!
(var"0 a) NB.where are the lvars
(var"0 a) *. (var"0 b) NB.var-var unify, candidates for walk
(var"0 a) +. (var"0 b) NB.all unify candidates
(var"0 a) ~: (var"0 b) NB.var-term unify candidates


unify =: 2 : 0
NB.CONTINUE HERE!
 if. (u&-:+.v&-:) ''
  do. 0 NB.#f equivalent, does not unify
 elseif. ($u)~:($v)
  do. 0 NB.different shape, does not unify
 end.
)