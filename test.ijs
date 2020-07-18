load'~Projects/mk/microkanren.ijs'

ini =: ''

fives =: 3 : 0
 ((5.0) equ (<:#y)) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
)
sixes =: 3 : 0
 ((6.0) equ (<:#y)) dis (3 : '<''sixes ('' , ((5!:5) <''y'') , '')''') y
)

fives_and_sixes =: 3 : 'fives dis sixes y'

letters =: 3 : 0
 ((2 3 $ a. {~ 65 + i. 6) equ (<:#y)) dis (3 : '<''letters ('' , ((5!:5) <''y'') , '')''') y
)

peano =: 3 : 0
 (3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''')@fsh) y
)

test_var_boxvar =: 3 : 'assert. 0&= var < 2'
test_var_boxempty =: 3 : 'assert. 0&= var < ini'
test_var_var =: 3 : 'assert. var 2'
test_var_empty =: 3 : 'assert. 0&= var ini'
test_var_char =: 3 : 'assert. 0&= var ''a'' '
test_var_boxchar =: 3 : 'assert. 0&= var <''a'' '
test_var_vecvar=:3 :'assert. 0&= var 2 + i. 2'
test_var_vecbox=:3 :'assert. 0&= var ;/ i. 2'

get_varempty_expect =: 'index error'
test_get_varempty =: 3 : 'assert. 2 -: ini get 2'
test_get_varself =: 3 : 'assert. 2 -: (0 ; 1 ; 2) get 2'
test_get_emptyempty =: 3 : 'assert. ini -: ini get '''' '
test_get_emptyvar =: 3 : 'assert. '''' -: (0 ; 1 ; 2) get '''' '
test_get_walk =: 3 : 'assert. 3&-: (0 ; 1 ; 3 ; 3) get 2'
test_get_walk_char =: 3 : 'assert. ''a''&-: (0 ; 1 ; 3 ; 4 ; ''a'') get 2'

test_occ_self =: 3 : 'assert. 0&= (< 2) occ (<2)'
test_occ_yes_simple =: 3 : 'assert. (< 2) occ (<< 2)'
test_occ_no =: 3 : 'assert. 0&= (< 2) occ (<3)'
test_occ_no_simple =: 3 : 'assert. 0&= (< 2) occ (<<3)'
test_occ_tree_no =: 3 : 'assert. 0&= (< 2 ) occ (< 3 ; 4 ; 5)'
test_occ_tree_yes =: 3 : 'assert. (< 2 ) occ (< 2 ; 3 ; 4)'
test_occ_nested =: 3 : 'assert. (< 2 ) occ (< (3 ; (<< (4 ; 2)) ; 4))'

test_ext_empty =: 3 : 'assert. (1 ; 1 ; 1) -: (1 ; 1 ; 1) ext (,: 0 ; 1 ; 1)'
test_ext_extend =: 3 : 'assert. (1 ; 1 ; 2) -: (0 ; 1 ; 2) ext (,: 0 ; 1)'
test_ext_occ =: 3 : 'assert. _1 -: (;/ i. 3) ext (,: 2 ; < < 2)'
test_ext_no_path_compression =: 3 : 'assert. (''z'' ; 0 ; ''z'') -: (''z'' ; 0 ; 2) ext (,: 2 ; 1)'

test_uni_bnull_bnull =: 3 : 'assert. ini -: (< '''') uni (< '''') ini '
test_uni_null_var =: 3 : 'assert. (0 ; '''') -: '''' uni 1 (0 ; 1)'
test_uni_var_var =: 3 : 'assert. (1 ; 1) -: 0 uni 1 (0 ; 1)'
test_uni_bvar_bvar =: 3 : 'assert. (1 ; 1) -: (<0) uni (<1) (0 ; 1)'
test_uni_unequal_shape =: 3 : 'assert. _1 -: (<0) uni (1 ; 2) (0 ; 1 ; 2)'
test_uni_equal =: 3 : 'assert. (0 ; 1 ; 2) -: 2 uni 2 (0 ; 1 ; 2)'
test_uni_occ =: 3 : 'assert. _1 -: 2 uni (<2) (0 ; 1 ; 2)'
test_uni_occ_walk =: 3 : 'assert. _1 -: 0 uni (<1) (0 ; 0)'
test_uni_crisscross =: 3 : 'assert. (''b'' ; ''a'') -: (''a'' ; 0) uni (1 ; ''b'') (0 ; 1)'
test_uni_nested =: 3 : 'assert. (''d'' ; ''c'') -: (''a'' ; < < (''c'' ; 0)) uni (''a'' ; < < (1 ; ''d'')) (0 ; 1)'
test_uni_walk =: 3 : 'assert. (''a'' ; 2 ; ''a'') -: 0 uni 1 (0 ; 2 ; ''a'')'
test_uni_subtree =: 3 : 'assert. (0 ; 1 ;<''a'';''b'') -: (0 1) 2 uni (''a'';''b'') (0 ; 1 ; 2)'
test_uni_subtree_var =: 3 : 'assert. ((1;''b'');1) -: 0 uni (1;''b'') (0 ; 1)'

uni_scope_error_expect =: 'index error'
test_uni_scope_error =: 3 : '0 uni 1 ini'

test_fsh_single =: 3 : 'assert. (,<0) -: fsh ini'
test_fsh_multiple =: 3 : 'assert. (0;1;2) -: fsh^:3 ini'

test_infinite_stream_dfs =: 3 : 'assert. (4 # <,<5.) -: 4 run fives ini'
test_infinite_stream_interleave =: 3 : 'assert. ((<,<5.),(<,<6.),(<,<5.),(<,<6.)) -: 4 run fives_and_sixes ini'

test_con1 =: 3 : 'assert. (, < ''z'' ; ''z'') -: (''z'' equ 0)@fsh con (1 equ 0)@fsh ini'
test_con2 =: 3 : 'assert. (, < ''z'' ; ''z'') -: ((0 0) ''z'' equ 0 fsh) con ((0 0) 1 equ 0 fsh) ini'

test_peano =: 3 : 'assert. ((<,<''z''),(<(<''s'';''z''),<''z''),<(<(<''s''),<''s'';''z''),(<''s'';''z''),<''z'') -: 3 run peano ini'

test_additional_1 =: 3 :'assert. (''a'';''b'';''c'') -: (0 0) (''a''; 1 ; 2) uni (0 ; ''b'' ; 2) (0 ; 1 ; ''c'')'
test_additional_2 =: 3 :'assert. (''a'';''b'';''c'') -: (0 0) (0 ; 1 ; 2) uni (''a'' ; ''b'' ; 2) (0 ; 1 ; ''c'')'
test_additional_3 =: 3 :'assert. (''a'';''b'';''c'') -: (0 0) (0 ; 1 ; 2) uni (''a'';''b'';''c'') (0 ; 1 ; ''c'')'
test_additional_4 =: 3 :'assert. (''a'' ; ''a'' ; ''c'') -: (0 0) (0 ; 1 ; 2) uni (''a'' ; 0 ; ''c'') (0 ; 1 ; ''c'')'
test_additional_5 =: 3 :'assert. (''a''; 1 ;''c'') -: (0 0) (0 ; 1 ; 2) uni (''a'' ; 1 ; ''c'') (0 ; 1 ; ''c'')'
test_additional_6 =: 3 :'assert. (''a'' ; ''a'' ; ''c'')-: (0 0) (0 ; 1 ; 2) uni (''a'' ; ''a'' ; ''c'') (0 ; 1 ; ''c'')'
test_additional_7 =: 3 :'assert. (''a'' ; ''c'' ; ''c'') -: (0 0) (0 ; 1 ; 2) uni (''a'' ; 2 ; ''c'') (0 ; 1 ; ''c'')'
test_additional_8 =: 3 :'assert. (''a'' ; ''b'' ; ''c'' ; ''d'') -: (0 0) (0 ; 1 ; 2) uni (''a'' ; ''b'' ; ''c'') (0 ; 1 ; 2 ; ''d'')'
test_additional_9 =: 3 :'assert. _1 -: (0 0) (0 ; 1 ; 2) uni (''a'' ; ''b'' ; ''c'') (0 ; 1 ; ''d'')'

test_rank_polymorphism =: 3 : 'assert. (<(4 2$''ABCDEFGH'');(4 2$''IJKLMNOP'');(4 2$''QRSTUVWX'');(4 2$''YZ[\]^_`'');(4 2$''abcdefgh'');4 2$''ijklmnop'') -: (0 2) (i.6) equ (6 4 2 $ a.{~65+i.48) fsh^:6 ini'

test_boxed_projection =: 3 : 'assert. (2 2$0;''a'';''a'';''a'') -: (0 1 ,. 1 2) bpro ''a'' equ 2  > 1 equ 2 fsh^:3 ini'
test_unboxed_projection =: 3 : 'assert. (2 2 $ ''a'') -: (0 1 ,. 1 2) upro ''a'' equ 2  > 1 equ 2 > 0 equ 1 fsh^:3 ini'

projection_domain_error_expect =: 'domain error'
test_projection_domain_error =: 3 : '(0 1 ,. 1 2) upro ''a'' equ 2  > 1 equ 2 fsh^:3 ini'

test_run_zero =: 3 : 'assert. '''' -: 0 run peano '''' '
test_run_one =: 3 : 'assert. (,<,<''z'')-: 1 run peano '''' '
test_run_more =: 3 : 'assert. ((<,<''z''),<(<''s'';''z''),<''z'') -: 2 run peano '''' '
test_run_nonrecursive =: 3 : 'assert. (<,<''a'') -: 2 run (''a'' equ 0) '''' '
test_run_projection =: 3 : 'assert. ((<<''z''),(<<''s'';''z''),<<(<''s''),<''s'';''z'') -: (0) 3 run peano ini'