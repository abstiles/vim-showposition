" ==============================================================================
"        File: showposition.vim
"      Author: Andrew Stiles
" Last Change: Sat Mar 03 11:30 AM 2012 CST
" Description: Draw attention to the current cursor position with a keystroke.
"
" This script draws a large block highlight around the cursor position to draw
" the user's attention. It maps Ctrl+P to a call to ShowPosition(), which uses
" a quick block selection to create the block highlight.
"
" Copyright (c) 2012 Andrew Stiles
"
"  Permission is hereby granted, free of charge, to any person obtaining a copy
"  of this software and associated documentation files (the "Software"), to
"  deal in the Software without restriction, including without limitation the
"  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
"  sell copies of the Software, and to permit persons to whom the Software is
"  furnished to do so, subject to the following conditions:
"
"  The above copyright notice and this permission notice shall be included in
"  all copies or substantial portions of the Software.
"
"  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
"  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
"  IN THE SOFTWARE.
" ==============================================================================

nnoremap <c-p> :call <SID>ShowPosition()<cr>

function! s:ShowPosition()
    let currentLine = line('.')
    let currentCol = virtcol('.')
	let currentRealCol = col('.')
    let veMode = &virtualedit

    let topLine = max([1, currentLine-1])
    let bottomLine = min([line('$'), currentLine+1])
    let leftCol = max([1, currentCol-1])
    let rightCol = currentCol+1
    set virtualedit=all
    "call cursor(topLine, leftCol)
	silent execute "normal! " . topLine . "G" . leftCol . "|"
    silent execute "normal! \<C-V>" . (rightCol-leftCol) . "l" . (bottomLine-topLine) . "j"
    redraw
    sleep 80m
    silent execute "normal! \<Esc>"
    "call cursor(currentLine, currentCol)
	silent execute "normal! " . currentLine . "G" . currentCol . "|"

    let topLine = max([1, currentLine-2])
    let bottomLine = min([line('$'), currentLine+2])
    let leftCol = max([1, currentCol-2])
    let rightCol = currentCol+2

    "call cursor(topLine, leftCol)
	silent execute "normal! " . topLine . "G" . leftCol . "|"
    silent execute "normal! \<C-V>" . (rightCol-leftCol) . "l" . (bottomLine-topLine) . "j"
    redraw
    sleep 80m
    silent execute "normal! \<Esc>"
    "call cursor(currentLine, currentRealCol)
	silent execute "normal! " . currentLine . "G" . currentCol . "|"

    silent execute "set virtualedit=" . veMode
endfunction
