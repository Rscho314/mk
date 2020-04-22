load'~Projects/mk/microkanren.ijs'

fives =: 3 : 0
 ((,5) equ (<:#y)) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
)
sixes =: 3 : 0
 ((,6) equ (<:#y)) dis (3 : '<''sixes ('' , ((5!:5) <''y'') , '')''') y
)

fives_and_sixes =: 3 : 'fives dis sixes y'

peano =: 3 : 0
 (3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''') fsh) y
)

test_var_bnat =: 3 : 'assert. 0&= var < 2'
test_var_bbool =: 3 : 'assert. 0&= var < 1'
test_var_bnull =: 3 : 'assert. 0&= var < '''''
test_var_nat =: 3 : 'assert. var 2'
test_var_bool =: 3 : 'assert.var 1'
test_var_null =: 3 : 'assert. 0&= var '''' '
test_var_char =: 3 : 'assert. 0&= var ''a'' '
test_var_bchar =: 3 : 'assert. 0&= var <''a'' '
test_var_vecint=:3 :'assert. 0&= var i. 2'
test_var_vecbox=:3 :'assert. 0&= var ;/ i. 2'

test_get_natempty =: 3 : 'assert. 2&-: '''' get 2'
test_get_natself =: 3 : 'assert. 2&-: (2 ; 2 ; 2) get 2'
test_get_nullempty =: 3 : 'assert. ''''&-: '''' get '''' '
test_get_nullnat =: 3 : 'assert. ''''&-: (2 ; 2 ; 2) get '''' '
test_get_walk =: 3 : 'assert. 4&-: (_. ; _. ; 3 ; 4) get 2'
test_get_walk_char =: 3 : 'assert. ''a''&-: (_. ; _. ; 3 ; 4 ; ''a'') get 2'

test_occ_self =: 3 : 'assert. (< 2 ; 2) occ '''' '
test_occ_yes_simple =: 3 : 'assert. (< 2 ; < < 2) occ '''' '
test_occ_no =: 3 : 'assert. 0&= (< 2 ; 3) occ '''' '
test_occ_no_simple =: 3 : 'assert. 0&= (< 2 ; < < 3) occ '''' '
test_occ_yes_walk =: 3 : 'assert. (< 2 ; < < 3) occ (_. ; _. ; 2 ; 2)'
test_occ_no_walk =: 3 : 'assert. 0&= (< 2 ; < < 3) occ (_. ; _. ; _. ; 4)'
test_occ_tree_no =: 3 : 'assert. 0&= (< 2 ; < (3 ; 4 ; 5)) occ '''' '
test_occ_tree_yes =: 3 : 'assert. (< 2 ; < (2 ; 3 ; 4)) occ '''' '
test_occ_nested =: 3 : 'assert. (< 2 ; < (3 ; (< < (4 ; 2)) ; 4)) occ '''' '
test_occ_nested_walk =: 3 : 'assert. (< 2 ; < (3 ; (< < (4 ; 3)) ; 4)) occ (_. ; _. ; 2 ; 2)'

test_ext_empty =: 3 : 'assert. ''_.;_.;3''&-: ((5!:5) < ''a'') [ a =. (< 2 ; 3) ext (_. ; _. ; _.)'
test_ext_append =: 3 : 'assert. ''_.;_.;_.;_.;5''&-: ((5!:5) < ''a'') [ a =. (< 4 ; 5) ext (_. ; _. ; _. ; _. ; _.)'
test_ext_equal_nonvar =: 3 : 'assert. ''_.;_.;,2''&-: ((5!:5) < ''a'') [ a =. (<(,2);,2) ext (_. ; _. ; _.)'
test_ext_equal_var =: 3 : 'assert. _1&-: (<2;2) ext (_. ; _. ; _.)'
test_ext_occ =: 3 : 'assert. _1&-: (< 2 ; < < 2) ext (_. ; _. ; _.)'
test_ext_same =: 3 : 'assert. ''(<_.),(<_.),<<2''&-: ((5!:5) < ''a'') [ a =. (< (<2); < < 2) ext (_. ; _. ; _.)'
test_ext_avoid_duplicate =: 3 : 'assert. ''_.;_.;''''z'''';2''&-: ((5!:5) < ''a'') [ a =.  (< 3 ; ''z'') ext (_. ; _. ; ''z'' ; _.)'
test_ext_no_path_compression =: 3 : 'assert. ''_.;_.;''''z'''';2;3''&-: ((5!:5) < ''a'') [ a =.  (< 4 ; 2) ext (_. ; _. ; ''z'' ; 2 ; _.)'

test_uni_null_null =: 3 : 'assert. ''''&-: '''' uni '''' '''' '
test_uni_bnull_bnull =: 3 : 'assert. ''''&-: (< '''') uni (< '''') '''' '
test_uni_null_nat =: 3 : 'assert. ''_.;''''''''''&-: ((5!:5) < ''a'') [ a =. '''' uni 1 (_. ; _.)'
test_uni_nat_nat =: 3 : 'assert. ''1;_.''&-: ((5!:5) < ''a'') [ a =. 0 uni 1 (_. ; _.)'
test_uni_bnat_bnat =: 3 : 'assert. ''1;_.''&-: ((5!:5) < ''a'') [ a =. (<0) uni (<1) (_. ; _.)'
test_uni_unequal_shape =: 3 : 'assert. _1&= (<0) uni (1;2) (_. ; _. ; _.)'
test_uni_equal =: 3 : 'assert. ''_.;_.;_.''&-: ((5!:5) < ''a'') [ a =. 2 uni 2 (_. ; _. ; _.)'
test_uni_occ =: 3 : 'assert. _1&= 2 uni (<2) (_. ; _. ; _.)'
test_uni_occ_walk =: 3 : 'assert. _1&= 0 uni (<1) (_. ; 0)'
test_uni_crisscross =: 3 : 'assert. (''b'' ; ''a'')&-: (''a'' ; 0) uni (1 ; ''b'') (_. ; _.)'
test_uni_nested =: 3 : 'assert. (''d'' ; ''c'')&-: (''a'' ; < < (''c'' ; 0)) uni (''b'' ; < < (1 ; ''d'')) (_. ; _.)'
test_uni_walk =: 3 : 'assert. (1 ; 2 ; ''a'')&-: 0 uni 1 (1 ; 2 ; ''a'')'
test_uni_walk_add =: 3 : 'assert. (''b'' ; ''a'' ; 0)&-: 0 uni 2 (''b'' ; ''a'' ; _.)'
test_uni_subtree =: 3 : 'assert. ''(<_.),(<_.),<''''a'''';''''b''''''&-: ((5!:5) < ''a'') [ a =. 2 uni (''a'';''b'') (_. ; _. ; _.)'

test_uni_subtree_var =: 3 : 'assert. ''(<1;''''b''''),<_.''&-: ((5!:5) < ''a'') [ a =. 0 uni (1;''b'') (_. ; _.)'

uni_scope_expect =: 'domain error'
test_uni_scope =: 3 : '0 uni 1 (,<_.)'

test_infinite_stream_dfs =: 3 : 'assert. (4 # << , 5)&-: 4 cis fives'
test_infinite_stream_interleave =: 3 : 'assert. (; 3 # (<(< , 5) ;<(< , 6)))&-: 6 cis fives_and_sixes'

test_con =: 3 : 'assert. (, < ''z'' ; 0)&-: (''z'' equ 0) con (1 equ 0 fsh) fsh '''' '

test_peano =: 3 : '(<<''z''),(<(<''s'';1),<''z''),<(<''s'';1),(<''s'';2),<''z''&-: (5!:5)<''a'' [ a =. 3 cis peano'