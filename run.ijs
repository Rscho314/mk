load'general/unittest'
load 'jpm'

test =: 3 : 0
 f =. 'var get occ ext uni equ fsh app apm dis con pul tak cis'
 pt =. jpath '~Projects/mk/test.ijs'
 pp =. jpath '~Projects/mk/microkanren.ijs'
 t =. 3 : ('unittest ''' , pt , '''')
 echo t ''
 NB.echo 'Character count: ' , (2!:0) 'tr -d ''[:space:]'' < ' , pp , '| wc -c'
 NB.start_jpm_ ''
 NB.t ''
 NB.echo 0 1 showtotal_jpm_ f
 NB.1 1 showtotal_jpm_ f
)