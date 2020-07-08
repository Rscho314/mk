load'~Projects/mk/microkanren.ijs'

NB.fives =: 3 : 0
NB.  ((5.0) equ (<:#y)) dis (3 : '<''fives ('' , ((5!:5) <''y'') , '')''') y
NB.)
NB.sixes =: 3 : 0
NB. ((6.0) equ (<:#y)) dis (3 : '<''sixes ('' , ((5!:5) <''y'') , '')''') y
NB.)

NB.fives_and_sixes =: 3 : 'fives dis sixes y'

NB.peano =: 3 : 0
NB. (3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''')@fsh) y
NB.)

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

uni_scope_expect =: 'index error'
test_uni_scope =: 3 : '0 uni 1 ini'

test_fsh_single =: 3 : 'assert. (,<0) -: fsh ini'
test_fsh_multiple =: 3 : 'assert. (0;1;2) -: fsh^:3 ini'

NB.test_infinite_stream_dfs =: 3 : 'assert. (4 # <<5.)&-: 4 run fives ini'
NB.test_infinite_stream_interleave =: 3 : 'assert. ((<<5.),(<<6.),(<<5.),<<6.)&-: 4 run fives_and_sixes ini'

NB.test_con1 =: 3 : 'assert. (, < ''z'' ; ''z'')&-: (''z'' equ 0) con (1 equ 0)@fsh (<_.)'
NB.test_con2 =: 3 : 'assert. (, < ''z'' ; ''z'')&-: ((0 0) ''z'' equ 0 ]) con ((0 0) 1 equ 0 fsh@]) <_.'

NB.test_peano =: 3 : '(<<''z''),(<(<''s'';1),<''z''),<(<''s'';1),(<''s'';2),<''z''&-: (5!:5)<''a'' [ a =. 3 run peano ini'

NB.test_additional_1 =: 3 :'assert. (''a'';''b'';''c'')-:(0 0) (''a'';1;2) uni (0;''b''; 2) (_. ; _. ; ''c'')'
NB.test_additional_2 =: 3 :'assert. (''a'';''b'';''c'')-:(0 0) (0;1;2) uni (''a'';''b''; 2) (_. ; _. ; ''c'')'
NB.test_additional_3 =: 3 :'assert. (''a'';''b'';''c'')-:(0 0)(0;1;2) uni (''a'';''b'';''c'') (_. ; _. ; ''c'')'
NB.test_additional_4 =: 3 :'assert. (''a'';0;''c'')-:(0 0) (0;1;2) uni (''a'';0;''c'') (_. ; _. ; ''c'')'
NB.test_additional_5 =: 3 :'assert. ''''''a'''';_.;''''c''''''-: (5!:5)<''a''[ a=.(0 0) (0;1;2) uni (''a'';1;''c'') (_. ; _. ; ''c'')'
NB.test_additional_6 =: 3 :'assert. (''a'';''a'';''c'')-:(0 0) (0;1;2) uni (''a'';''a'';''c'') (_. ; _. ; ''c'')'
NB.test_additional_7 =: 3 :'assert. (''a'';2;''c'')-:(0 0) (0;1;2) uni (''a'';2;''c'') (_. ; _. ; ''c'')'
NB.test_additional_8 =: 3 :'assert. (''a'';''b'';''c'';''d'')-:(0 0) (0;1;2) uni (''a'';''b'';''c'') (_. ; _. ; _. ; ''d'')'
NB.test_additional_9 =: 3 :'assert. _1&= (0 0) (0;1;2) uni (''a'';''b'';''c'') (_. ; _. ; ''d'')'

NB.test_rank_polymorphism =: 3 : '(0 2) (i.6) equ (6 4 2 $ a.{~65+i.48) 6#<_.'