fun DotfileDiff()
	silent execute "!diff --text --binary "
		\ . "-I '\\$dotignore\\$' -I '\\$dotid' "
		\ . v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfun
set diffexpr=DotfileDiff()

nnoremap <Leader>dr <C-w><C-w>1GV0Gy<C-w><C-w>1GV0Gp:wqa<CR>