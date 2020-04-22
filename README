# Microkanren in J

This work is under the LGPL v. 3.0.

This is an implemenetation of the minimal logic language described in:

@inproceedings{10.1145/2989225.2989230,
author = {Hemann, Jason and Friedman, Daniel P. and Byrd, William E. and Might, Matthew},
title = {A Small Embedding of Logic Programming with a Simple Complete Search},
year = {2016},
isbn = {9781450344456},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
url = {https://doi.org/10.1145/2989225.2989230},
doi = {10.1145/2989225.2989230},
booktitle = {Proceedings of the 12th Symposium on Dynamic Languages},
pages = {96–107},
numpages = {12},
keywords = {microKanren, search, relational programming, logic programming, Racket, miniKanren, streams},
location = {Amsterdam, Netherlands},
series = {DLS 2016}
}

@article{10.1145/3093334.2989230,
author = {Hemann, Jason and Friedman, Daniel P. and Byrd, William E. and Might, Matthew},
title = {A Small Embedding of Logic Programming with a Simple Complete Search},
year = {2016},
issue_date = {May 2017},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
volume = {52},
number = {2},
issn = {0362-1340},
url = {https://doi.org/10.1145/3093334.2989230},
doi = {10.1145/3093334.2989230},
journal = {SIGPLAN Not.},
month = nov,
pages = {96–107},
numpages = {12},
keywords = {Racket, logic programming, search, miniKanren, streams, relational programming, microKanren}
}

## Quick tour

- To use, `load microkanren.ijs`
- Only has the equality constraint for now.
- Only the pure core language is implemented, *i.e.* no impure operators such as conda, condu, etc. No conde, disj+ or conj+ either.
- Yes, at the moment it is a pain to use but I hope to make that change.

### renaming of functions from the paper

- var? -> var
- find -> get
- occurs? -> occ
- ext-s -> ext
- unify -> uni
- == -> equ
- call/fresh -> fsh
- $append -> app
- $append-map -> apm
- disj -> dis
- conj -> con
- pull -> pul
- take -> tak
- call/initial-state -> cis

## Examples

### infinite streams
`10 cis fives`

### interleaving search
`3 cis fives_and_sixes`

### peano numbers (currently, the pinnacle of this library)
`5 cis peano`

## Future directions

- polish the current implementation a bit
- implement the constraint store using Jd, the embedded J columnar-store
- moar constraints, make it easier to use
