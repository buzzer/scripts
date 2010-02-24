#!/bin/bash
# See URL:
# http://vim.wikia.com/wiki/C%2B%2B_code_completion

mkdir ~/.vim      2> /dev/null
mkdir ~/.vim/tags 2> /dev/null

# Example for future tags run:
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ ~/.vim/tags/cpp_src && mv tags cpp # for stdc++
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/local/include/player-3.0/ && mv tags player # for Player
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/local/include/Stage-3.1/ && mv tags stage # for Stage

