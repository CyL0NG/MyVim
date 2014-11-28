set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme molokai                  "颜色主题
"使注释和特殊符号更好看
highlight Comment    ctermfg=245 guifg=#8a8a8a
highlight NonText    ctermfg=240 guifg=#585858
highlight SpecialKey ctermfg=240 guifg=#585858

set guioptions-=m                    "隐藏工具栏和菜单栏
set guioptions-=T

set bsdir=buffer                     "设置工作目录为当前编辑文件的目录
set autochdir

set enc=utf-8                        "编码设置
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

set autoread                         "文件修改之后自动载入
set shortmess=atI                    "不显示援助

set langmenu=zh_CN.UTF-8             "语言设置
language message zh_CN.UTF-8

set guifont=YaHei\ Consolas\ Hybrid:h12     "字体设置
set helplang=cn

set nobackup                         "设置取消备份 禁止临时文件生成
set noswapfile

if has('persistent_undo')
    set undolevels=1000
    set undoreload=10000
    set undofile
    set undodir=$VIMRUNTIME/vimundo/
endif

set ignorecase                       "设置搜索时忽略大小写
set incsearch hlsearch smartcase     "搜索逐字符高亮，智能搜索

set smarttab expandtab               "智能tab
set autoindent cindent smartindent shiftround
set shiftwidth=4 softtabstop=4 tabstop=4

set foldenable                       "代码折叠
set foldmethod=indent
set foldlevel=99

set list listchars=eol:◣,tab:--,trail:.,
set backspace=indent,eol,start       "配置backspace键工作方式
set nu rnu                           "显示相对行号
autocmd InsertEnter * :set norelativenumber number      "插入模式显示绝对行号
autocmd InsertLeave * :set relativenumber               "普通模式显示相对行号
set ruler                            "设置在编辑过程中右下角显示光标的行列信息
set cursorline                       "突出现实当前列
set cursorcolumn                     "突出现实当前列
set showcmd                          "在状态栏显示正在输入的命令
set novisualbell                     "do not beep
set noerrorbells                     "do not beep
set scrolloff=5
set showmode                         "显示当前模式
set history=1000                     "设置历史记录条数
set clipboard+=unnamed               "与Windows共享剪贴板
autocmd! bufwritepost _vimrc source $VIM/_vimrc            "编辑vimc之后，重新加载
set showmatch matchtime=1            "设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
syntax enable                        "开启语法高亮功能
syntax on
set t_Co=256                         "指定配色方案为256色
set mouse=a                          "设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
language messages zh_CN.utf-8        "解决consle输出乱码

let mapleader = ','
let g:mapleader = ','

map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>
map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

nnoremap <C-t>      :tabnew<CR>
inoremap <C-t>      <Esc>:tabnew<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

if has('multi_byte_ime')             "输入设置
    "未开启IME时光标背景色
    hi Cursor guifg=bg guibg=Orange gui=NONE
    "开启IME时光标背景色
    hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
    " 关闭Vim的自动切换IME输入法(插入模式和检索模式)
    set iminsert=0 imsearch=0
endif

filetype indent on                   "针对不同的文件采用不同的缩进方式
filetype plugin indent on
set completeopt=longest,menu
set wildmenu                         "自动补全命令时候使用菜单式匹配列表  
autocmd FileType uby,euby set omnifunc=ubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascipt set omnifunc=javasciptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet

"保存文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,javascript,jsp,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

autocmd BufNewFile *.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    call setline(1, "\#!/usr/bin/python")
    call append(1, "\# encoding: utf-8")
endfunction
"F10 run python
nnoremap <buffer> <F10> :exec '!python' shellescape(@%, 1)<cr>
"==============插件配置=============
"允许插件
filetype plugin on
"开始使用Vundle的必须配置
filetype on
set rtp+=$vim/vimfiles/bundle/vundle/
call vundle#rc('$vim/vimfiles/bundle')

Plugin 'gmarik/vundle'                  "使用Vundle来管理Vundle

Plugin 'bling/vim-airline'
Plugin 'scrooloose/vim-statline'
"#############syntastic######################
Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting=0
let g:syntastic_python_checks=['pyflakes']
let g:syntastic_javascript_checks=['jsl', 'jshint']
let g:synstatic_html_checkers=['tidy', 'jshint']
highlight SyntasticErrorSign guifg=white guibg=black

"#############快速注释#####################
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1

"#############快速赋值语句对齐#############
Plugin 'junegunn/vim-easy-align'
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

"#############区块伸缩#####################
Plugin 'terryma/vim-expand-region'

"#############多光标选中编辑###############
Plugin 'vim-multiple-cursors'

"#############括号增强显示#################
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle=0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"#############快速文档注释###############
Plugin 'DoxygenToolkit.vim'
map fg : Dox<cr>
let g:DoxygenToolkit_authorName="cylong"
let g:DoxygenToolkit_licenseTag="GNU License\<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief\t"
let g:DoxygenToolkit_paramTag_pre = "@param\t"
let g:DoxygenToolkit_returnTag = "@return\t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30

"#############快速导航###################
Plugin 'scrooloose/nerdtree'
map <leader>n :NERDTreeToggle<CR>
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowLineNumbers=0
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.o$', '\.git$']
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0

"#############python#####################
Plugin 'kevinw/pyflakes-vim'
let g:pyflakes_use_quickfix=0

Plugin 'hdima/python-syntax'
let python_highlight_all=1

let g:pydiction_location='$vim/vim74/ftplugin/python_pydiction'

"#############html/js/jquery/css#########
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

Plugin 'nono/jquery.vim'
Plugin 'mattn/emmet-vim'

"#############自动补全###################
Plugin 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_enable_auto_select = 1
set completeopt-=preview

"#############tab########################
Plugin 'minibufexplorerpp'
let g:miniBufExpMapWindowNavVim = 1
let g:miniBufExplMapWindowNavAows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTaget = 1

"##########插件管理 结束#############

" { Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 230
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 Alt+Enter 切换全屏vim
    map <a-enter> <esc>:call ToggleFullScreen()<cr>
    "切换Vim是否在最前面显示
    nmap <s-r> <esc>:call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    nmap <s-t> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    nmap <s-y> <esc>:call SetAlpha(-10)<cr> 
    "默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif
" }
