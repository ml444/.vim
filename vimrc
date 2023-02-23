"========================================"
" let do_syntax_sel_menu = 1 "菜单加载所有文件类型
" let do_no_lazyload_menus = 1 "菜单的延迟加载
" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

syntax enable " 语法高亮
if !(($TERM_PROGRAM == "Apple_Terminal")||($TERM_PROGRAM == ""))
    "let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"      " 设置前景色
    "let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"      " 设置背景色
	set termguicolors       " 为终端启用 GUI 颜色以获得真彩色(24色)
endif

"colorscheme neodark
"colorscheme molokai
colorscheme mydarcula
set t_Co=256 " 启用 256 色
set background=dark " 主题背景 dark-深色; light-浅色

"Vim原始注释的颜色为蓝色极其不清楚，将其改为灰色
"highlight Comment ctermfg=gray guifg=gray
" 用下划线展示当前行
""autocmd InsertEnter * se cul



" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.py write
au BufRead,BufNewFile *.go set filetype=go
":autocmd InsertEnter * set timeoutlen=200
":autocmd InsertLeave * set timeoutlen=1000
autocmd!   BufNewFile,BufRead *    setlocal nofoldenable


"--------缩进相关设置--------
set autoindent      " 自动缩进
set cindent         " 自动缩进
set tabstop=4       " Tab键的宽度; 临时设置时，可以使用 :retab 把之前缩进的tab改为空格
set softtabstop=4   " 统一缩进为4
set shiftwidth=4    " 回车插入时自动缩进数
"set noexpandtab    " 不要用空格代替制表符
set expandtab 		" 制表符转空格converting tabs to spaces
set smarttab        " 在行和段开始处使用制表符
set backspace=2     " 解决：删除键(backspace)只能删除到行首不能跳到上一行
"set smartindent     " 开启新行时使用智能自动缩进


"--------------cmd-----------------
"set cmdheight=1    " 设定命令行的行数为 1
set showcmd         " 输入的命令显示出来，看的清楚些 

set enc=utf-8
"set guifont=Courier_new:h20
"set guioptions-=T " 隐藏工具栏
"set guioptions-=m " 隐藏菜单栏
set nu              " 显示行号
set timeoutlen=500
set noeb            " 去掉输入错误的提示声音

"-----------backup------------------"
"set backupcopy=yes " 设置备份时的行为为覆盖
set nobackup        "取消自动备份
set noswapfile      "取消产生swp文件
set undofile
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
	call mkdir(&undodir, 'p', 0700)
endif


set autoread    "当文件被外部改变时自动读取


"---------------状态栏-------------"
"set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\   " 设置在状态行显示的信息


"-------------搜索-----------------
set ignorecase  " 搜索时忽略大小写
set smartcase   " 若搜索内容中有大写字母，则不再忽略大小写
set nowrapscan  " 禁止在搜索到文件两端时重新搜索
set incsearch   " 输入搜索内容时就显示搜索结果
set hlsearch    " 搜索时高亮显示被找到的文本
" 取消搜索高亮
nnoremap <silent> <F2>      :nohlsearch<CR>     
inoremap <silent> <F2> <C-O>:nohlsearch<CR>

set colorcolumn=80  " 高亮第80列
set cursorline      " 高亮光标所在行
set mouse=a         " 允许鼠标点击定位
set autochdir       " 自动切换当前目录为当前文件所在的目录
"let mapleader=";"  " 定义快捷键的前缀，即<Leader>

"inoremap <S><CR> <Esc>o
"nnoremap <S><CR> o


" -----------窗口切换---------------
nnoremap <Leader><Tab> <C-W>w
inoremap <Leader><Tab> <C-O><C-W>w
nnoremap <S-Tab> <C-W>W
inoremap <S-Tab> <C-O><C-W>W



"===============================================================================
">>>>>>>>>>>>>>>> 折叠（fold）<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"za	打开/关闭当前的折叠
"zc	关闭当前打开的折叠
"zo	打开当前的折叠
"zm	关闭所有折叠
"zM	关闭所有折叠及其嵌套的折叠
"zr	打开所有折叠
"zR	打开所有折叠及其嵌套的折叠
"zd	删除当前折叠
"zE	删除所有折叠
"zj	移动至下一个折叠
"zk	移动至上一个折叠
"zn	禁用折叠
"zN	启用折叠
"===============================================================================
"set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
"set foldclose=all " 设置为自动关闭折叠
" nnoremap <space> @=((foldclosed(line(’.’)) < 0) ? ‘zc’ : ‘zo’)<CR>    " 用空格键来开关折叠
nnoremap <space> za


"===============================================================================
">>>>>>>>>>>>>>>> 系统剪切板复制粘贴 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" ==== 系统剪切板复制粘贴 ====
" v 模式下复制内容到系统剪切板
vmap <Leader>c "+yy
" n 模式下复制一行到系统剪切板
nmap <Leader>c "+yy
" n 模式下粘贴系统剪切板的内容
nmap <Leader>v "+p

" buffers切换快捷键
nmap <Leader>[ :bprevious<CR>
nmap <Leader>] :bnext<CR>

"===============================================================================
">>>>>>>>>>>>>>>> terminal <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" vim-powered terminal in split window
map <Leader>t :term ++close<cr>
tmap <Leader>t <c-w>:term ++close<cr>

" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>
tmap <Leader>T <c-w>:tab term ++close<cr>



" ---Cursor Mode settings(光标模式)---
" 1 -> blinking block           闪烁的方块
" 2 -> solid block              不闪烁的方块
" 3 -> blinking underscore      闪烁的下划线
" 4 -> solid underscore         不闪烁的下划线
" 5 -> blinking vertical bar    闪烁的竖线
" 6 -> solid vertical bar       不闪烁的竖线
let &t_SI.="\e[5 q"     " SI=Insert mode
let &t_EI.="\e[1 q"     " EI=Nolmal mode
" let &t_SR.="\e[4 q"     " SR=Replace mode
let &t_SR = "\<Esc>[1 q" . "\<Esc>]12;green\x7"


"--------自动补全各种括号引号------------
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
"inoremap < <><Esc>i
inoremap { {}<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i
inoremap { {}<Esc>i
" inoremap { {<CR>}<Esc>O
"inoremap ' <c-r>=ClosePair("'")<CR>
"inoremap " <c-r>=ClosePair('"')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$")
      \ |   exe "normal! g`\""
      \ | endif


"filetype off
set packpath^=~/.vim
" git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
if exists('g:loaded_minpac')
  " Minpac is loaded.
  call minpac#init()
  " call minpac#add('k-takata/minpac', {'type': 'opt'})

  " ---Other plugins---
  call minpac#add('preservim/nerdtree')
  call minpac#add('preservim/nerdcommenter')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  call minpac#add('yegappan/mru')
  call minpac#add('fatih/vim-go')
  call minpac#add('Valloric/YouCompleteMe')
  call minpac#add('preservim/tagbar')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('mg979/vim-visual-multi')
  "call minpac#add('ianva/vim-youdao-translater')
  call minpac#add('git@github.com:ianva/vim-youdao-translater.git')
  "call minpac#add('KeitaNakamura/neodark.vim')      " 配色方案：colorscheme neodark
  " call minpac#add('git@github.com:preservim/vim-markdown.git')      
  " call minpac#add('iamcco/markdown-preview.vim')      
  " call minpac#add('iamcco/mathjax-support-for-mkdp')      
  call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
  call minpac#add('junegunn/fzf.vim')
endif

filetype plugin indent on


if has('eval')
  " Minpac commands
  command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
  command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
  command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
endif


if !has('gui_running')
  let g:NERDMenuMode = 0

  " 设置文本菜单
  if has('wildmenu')
    set wildmenu
    set cpoptions-=<
    set wildcharm=<C-Z>
    "nnoremap <F10>      :emenu <C-Z>
    "inoremap <F10> <C-O>:emenu <C-Z>
  endif
endif

" Other plugins
" packadd minpac

"===============================================================================
">>>>>>>>>>>>>>>> NERDTree <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
"自动打开nerdtree,取消下面注释则开启
"autocmd vimenter * NERDTree 
"更改默认箭头图标
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"让Tree把自己给装饰的多姿多彩漂亮点
let NERDChristmasTree=1
nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <F6> :NERDTreeToggle<CR>. " 打开树形目录
nnoremap <C-f> :NERDTreeFind<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '.idea']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2

" 在终端启动vim时，共享NERDTree 
let g:nerdtree_tabs_open_on_console_startup=1



"===============================================================================
">>>>>>>>>>>>>>>> NERDCommenter <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
"代码注释快捷键
"  行内注释（可视模式下，局部注释）：
"  <Leader>cc       把代码注释
"  <Leader>cu       取消注释
"  整行或多行注释：
"  <Leader>c<Space> 用来切换注释和非注释
"  <Leader>cb       用来加上“美观”的注释
"  <Leader>cs       用来加上“性感”的注释


"===============================================================================
">>>>>>>>>>>>>>>> Visual-Multi <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" :help vm-quick-reference

"===============================================================================
">>>>>>>>>>>>>>>> Fugitive <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" :help fugitive-staging-maps
" - 使用 `s` 来把文件（整个文件）或光标下的修改（部分修改）加到暂存区中
" - 使用 `u` 来重置加入暂存区的修改（撤销 `s`）
" - 使用 `=` 来切换开关这个文件的内联 diff 显示
" - 使用 `o` 来在新分割的窗口中打开文件
" - 使用 `dv` 来比较文件和暂存区版本的区别
" - 使用 `cc` 来签入（commit）当前暂存区中的文件，相当于 `:Git commit` 命令



"===============================================================================
">>>>>>>>>>>>>>>> GitGutter <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" - `[c` 和 `]c` 可以用来跳转到上一个和下一个修改的位置
" - `<Leader>hp` 可以将光标下的修改块和缓存区中的内容进行对比
" - `<Leader>hs` 可以将光标下的修改块加入到暂存区中
" - `<Leader>hu` 可以恢复暂存区中的内容 


"===============================================================================
">>>>>>>>>>>>>>>> Vim-Go <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
"let g:godef_split=2
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"  " locationlist
let g:go_auto_sameids = 1       " 相同变量或函数方法高亮显示

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_build_constraints = 1

nnoremap <C-S-l> :GoFmt<CR>
"au InsertLeave *.go GoFmt<CR>

"===============================================================================
">>>>>>>>>>>>>>>> Tagbar <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
nmap <F7> :TagbarToggle<CR>

"let g:tagbar_autopreview = 1 "开启自动预览(随着光标在标签上的移动，顶部会出现一个实时的预览窗口 
let g:tagbar_sort = 0 "关闭排序,即按标签本身在文件中的位置排序
"let g:tagbar_left = 1 "默认在右边，设置在左边
let g:tagbar_width = 30 "宽度
let g:tagbar_type_go = { 
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [ 
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : { 
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : { 
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"===============================================================================
">>>>>>>>>>>>>>>> vim-youdao-translater <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
"在普通模式下，按 ctrl+t， 会翻译当前光标下的单词；
"在 visual 模式下选中单词或语句，按 ctrl+t，会翻译选择的单词或语句；
"点击引导键再点y，d，可以在命令行输入要翻译的单词或语句；译文将会在编辑器底部的命令栏显示。
vnoremap <Leader>y :<C-u>Ydv<CR>
nnoremap <Leader>y :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

"===============================================================================
">>>>>>>>>>>>>>>> airline <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
set showtabline=2
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'  "default/jsformatter/unique_tail/unique_tail_improved
let g:airline#extensions#tabline#show_buffers= 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#show_tab_nr = 0
""let g:airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#show_tab_count = 0
"let g:airline#extensions#tabline#show_close_button = 0



"===============================================================================
">>>>>>>>>>>>>>>> fzf <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
"let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
"let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Empty value to disable preview window altogether
"let g:fzf_preview_window = []

" [Buffers] Jump to the existing window if possible
"let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
"let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
"let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
"let g:fzf_commands_expect = 'alt-enter,ctrl-x'



"===============================================================================
">>>>>>>>>>>>>>>> YouCompleteMe <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"===============================================================================
nnoremap <Leader>fi :YcmCompleter FixIt<CR>     
nnoremap <Leader>gt :YcmCompleter GoTo<CR>      "无脑跳转，最常用的就是这个功能，如果能跳转到定义，就跳转到定义，否则就跳转到声明
nnoremap <Leader>gd :YcmCompleter GoToDefinition<CR>    "跳转到定义
nnoremap <Leader>gh :YcmCompleter GoToDeclaration<CR>   "跳转到声明
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>    "可以用来查出一个符号被引用的地方（libclang 引擎不支持该命令）

"用来禁用光标在一个符号上长期停留出现的自动文档提示:
"let g:ycm_auto_hover = ''

"表示在写注释的时候也能启用自动完成——毕竟注释里通常也要写代码里的变量、函数名什么的。
let g:ycm_complete_in_comments = 1

"用来仅对白名单列表里的文件类型才启用 YCM。没有这一项，YCM 在打开一些特殊类型的文件时可能会报错，有时候也会导致打开的延迟。
"let g:ycm_filetype_whitelist = {
      "\ 'c': 1,
      "\ 'cpp': 1,
      "\ 'python': 1,
      "\ 'vim': 1,
      "\ 'sh': 1,
      "\ 'zsh': 1,
      "\ }

"用来告诉 YCM，当跳转的目的文件尚未打开时，用分割窗口的方式打开新文件；如果已经打开则跳转到相应的窗口。
"其他的可能值是 `'same-buffer'`，在同一个缓冲区的位置打开（除非这个位置因为文件修改的原因不能被替换），
"及 `'split'`，除非跳转目的在同一个文件，永远在新分割的窗口打开。
let g:ycm_goto_buffer_command = 'split-or-existing-window'

"用来定义手工启用语义完成的按键。
"在你输入时，YCM 会自动尝试标识符匹配，而当你输入 `.`、 `->`、 `::` 或这个按键时，
"YCM 则会启用语义完成，来给出当前上下文中允许出现的符号。
"这个按键默认是 `<C-Space>`，在某些操作系统上是不能用的（如 Mac 和老的 Windows），
"所以我改成了 `<C-Z>`。你也可以选择你自己喜欢的按键
"（但要注意映射冲突问题：Vim 里在插入模式下的可用键不多，
"事实上只有在终端下容易出问题的 `<C-S>` 和 `<C-Z>` 在 Vim 里没有默认功能）。
"let g:ycm_key_invoke_completion = '<C-Z>'

"重命名的重构.不能通过按键映射
"这个命令需要你把光标移到要修改的符号上，然后输入的命令里要有新的名称。
"比如，如果你要把一个 `foo` 符号重命名成 `bar`，需要把光标移动 `foo` 上面，然后输入：
":YcmCompleter RefactorRename bar
"
"YCM 默认只在屏幕底部显示当前行的问题，并且显示很可能被截断。
"要看到所有的代码问题，可以使用命令 `:YcmDiags`。


" ---你就得让Vim知道，你到底是在输入还是在粘贴----
" ---手工设置: before（:set paste）after（:set nopaste）
" ---Vim 8.0.0210 开始引入了对括号粘贴模式的支持。
" ---如果你使用的是 Vim 8.0.0210 之前的版本的话，那我们至少也可以通过代码来使得手工设置 paste 选项变得不必要:
if !has('patch-8.0.210')
  " 进入插入模式时启用括号粘贴模式
  let &t_SI .= "\<Esc>[?2004h"
  " 退出插入模式时停用括号粘贴模式
  let &t_EI .= "\<Esc>[?2004l"
  " 见到 <Esc>[200~ 就调用 XTermPasteBegin
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

  function! XTermPasteBegin()
    " 设置使用 <Esc>[201~ 关闭粘贴模式
    set pastetoggle=<Esc>[201~
    " 开启粘贴模式
    set paste
    return ""
  endfunction
endif


" ---如果我们使用图形界面 Vim 8 的话，Vim 支持在文件已经打开时自动切换到已经打开的 Vim 窗口上。
" ---不过，这个功能不是默认激活的，我们需要在 vimrc 中加入以下内容：
if v:version >= 800
  packadd! editexisting
endif
