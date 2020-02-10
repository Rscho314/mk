load'~Projects/mk/microkanren.ijs'

test_var_bnat =: 3 : 'assert. var (<2)'
test_var_bbool =: 3 : 'assert. var (<1)'
var_bnull_expect =: 'assertion failure'
test_var_bnull =: 3 : 'assert. var (<'''')'
var_nat_expect =: 'assertion failure'
test_var_nat =: 3 : 'assert. var (2)'
var_bool_expect =: 'assertion failure'
test_var_bool =: 3 : 'assert. var (1)'
var_null_expect =: 'assertion failure'
test_var_null =: 3 : 'assert. var '''''

test_find_bnat_empty =: 3 : 'assert.(<2)&-:(<2) find (0;'''';'''')'
test_find_bnat_term =: 3 : 'assert.(<1)&-:(<2) find (0;(<2);<<1)'
test_find_bnat_bnat =: 3 : 'assert.(<3)&-:(<2) find (0;(<2);<<3)'
test_find_bnat_char =: 3 : 'assert.(<''a'')&-:(<2) find (0;(<2);<<''a'')'
test_find_bnat_null =: 3 : 'assert.(<'''')&-:(<2) find (0;(<2);<<'''')'
test_find_bnat_walk =: 3 : 'assert.(<4)&-:(<2) find (0;(2;3);<3;4)'
NB. find does not do the occur check & always succeeds
test_find_bnat_stackerr =: 3 : 'assert.(<2)&-:(<2) find (0;(<2);<<2)'

test_exts_notempty =: 3 :'assert.(0;(3;2);<4;1)&-:(<2) exts (<1) (0;(<3);<<4)'
test_exts_empty =: 3 :'assert.(0;(,<2);<,<1)&-:(<2) exts (<1) (0;'''';'''')'

test_occurs_yes =: 3 :'assert. (<4) occurs (0;(3;2);<4;1)'
test_occurs_no =: 3 :'assert. 0&=(<0) occurs (0;(3;2);<4;1)'
test_occurs_wrong =: 3 :'assert. 0&=(0) occurs (0;(3;2);<4;1)'
test_occurs_empty =: 3 :'assert. 0&=(<4) occurs (0;'''';'''')'