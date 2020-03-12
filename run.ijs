load'general/unittest'
load 'jpm'

test =: 3 : 0
 f =. 'var get occ ext uni'
 pt =. jpath '~Projects/mk/test.ijs'
 pp =. jpath '~Projects/mk/microkanren.ijs'
 t =. 3 : ('unittest ''' , pt , '''')
 echo t ''
 echo 'Character count: ' , (2!:0) 'tr -d ''[:space:]'' < ' , pp , '| wc -c'
 start_jpm_ ''
 t ''
 echo 0 1 showtotal_jpm_ f
 1 1 showtotal_jpm_ f
)