NB. test
NB.
NB. This builds html docs in the Target directory, that should match
NB. those distributed in ~addons/docs/joxygen/testdocs

require 'docs/joxygen'

NB. source directory (used to find source files,
NB. but not used in the html docs)
Source=: jpath '~Projects/mk'

NB. target directory
Target=: jpath '~Projects/mk/docs'

NB. source files under the source directory
NB. (may be more than one level down)
Files=: cutopen 0 : 0
docs_microkanren.ijs
microkanren.ijs
)

NB. header for main page index.htm
IndexHdr=: 0 : 0
Microkanren in J: an implementation attempt
)

NB. ensure the Target directory is created
mkdir_j_ Target

NB. copy the css file to the Target directory
(Target,'/microkanren.css') fcopynew '~addons/docs/joxygen/joxygen.css'

NB. make the docs
makedocs''
echo 'building documentation'
