set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
"颜色主题
colorscheme molokai
"隐藏工具栏和菜单栏
set guioptions-=m
set guioptions-=T
"设置工作目录为当前编辑文件的目录
set bsdir=buffer
set autochdir
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set guifont=YaHei\ Consolas\ Hybrid:h12
set helplang=cn
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile
"设置搜索时忽略大小写
set ignorecase
"搜索逐字符高亮
set incsearch
"搜素时高亮显示被找到的文本
set hlsearch
"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctl + V + Tab]
set expandtab
"自动缩进
set noautoindent
set cindent
set smartindent
"配置backspace键工作方式
set backspace=indent,eol,start
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"突出现实当前行列
set cursorline
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"输入法设置
if has('multi_byte_ime')
    "未开启IME时光标背景色
    hi Cursor guifg=bg guibg=Orange gui=NONE
    "开启IME时光标背景色
    hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
    " 关闭Vim的自动切换IME输入法(插入模式和检索模式)
    set iminsert=0 imsearch=0
    " 插入模式输入法状态未被记录时，默认关闭IME
    "inoemap <silent> <ESC> <ESC>:set iminset=0<C>
endif
"与Windows共享剪贴板
set clipboard+=unnamed
"编辑vimc之后，重新加载
autocmd! bufwritepost _vimrc source $VIM/_vimrc
"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch
"开启语法高亮功能
syntax enable
syntax on
"指定配色方案为256色
set t_Co=256
"设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a
"解决consle输出乱码"
language messages zh_CN.utf-8
"针对不同的文件采用不同的缩进方式
filetype plugin indent on
set completeopt=longest,menu
"自动补全命令时候使用菜单式匹配列表  
set wildmenu
autocmd FileType uby,euby set omnifunc=ubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascipt set omnifunc=javasciptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet
"mm : 规范行首空格<cr>去除多余字符<cr>删除空白行<cr>规范行数
nmap mm :%s/\r//g<cr>
"ff : 前后补全
"vmap ff <Esc>`>i')?><Esc>`<i<?=$this->_('<Esc>
vmap ff "zdi<?=$this->_('<C-R>z');?><ESC>
"==============插件配置=============
"允许插件
filetype plugin on
"开始使用Vundle的必须配置
filetype on
set rtp+=$vim/vimfiles/bundle/vundle/
call vundle#rc('$vim/vimfiles/bundle')

"使用Vundle来管理Vundle
Plugin 'gmarik/vundle'
Plugin 'JavaScript-syntax'
Plugin 'jQuery'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'MatchTag'
Plugin 'tabular'
Plugin 'Lokaltog/vim-powerline'
Plugin 'xolox/vim-misc'
"注释插件
Plugin 'The-NERD-Commenter'
Plugin 'scrooloose/vim-statline'

"{plugin vim session and its configuration
Plugin 'xolox/vim-session'
let g:session_autoload='yes'
let g:session_autosave='yes'
"}

"{ plugin omnicppcomplete and its configuration
"func: 实现C/C++语言自动补全
Plugin 'OmniCppComplete'
" build tags of your own project with CTRL+F12
set tags=tags;
" tags目录
set tags+=$VIM/vimfiles/tags/cpp
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"}

"{ plugin DoxygentToolkit and its configuration
"由注释生成文档，并且能够快速生成函数标准注释
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
"}

"{ plugin The-NERD-tree and its configuration
"文件管理器
Plugin 'The-NERD-tree'
" 让Tree把自己给装饰得多姿多彩漂亮点
let NERDChristmasTree=1
" 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenter=1
" 指定鼠标模式(1.双击打开 2.单目录双文件 3.单击打开)
let NERDTreeMouseMode=2
" 是否默认显示书签列表
let NERDTreeShowBookmarks=1
" 是否默认显示文件
let NERDTreeShowFiles=1
" 是否默认显示行号
let NERDTreeShowLineNumbers=0
" 窗口位置（'left' or 'right'）
let NERDTreeWinPos='left'
" 窗口宽度
let NERDTreeWinSize=31
"A-t : 打开NERDTree
map <silent> <C-t>   <ESC>:NERDTree<CR>
" 以打开NERDTree时的目录为工作目录
let NERDTreeChDirMode=1
"}

"{ plugin Shougo/neocomplcache and its configuration
"代码补全
Plugin 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

set completeopt-=preview
"}

"{ plugin Shougo/neosnippet and its configuration
Plugin 'Shougo/neosnippet'
let g:neosnippet#snippets_directory=$VIMFILES.'/bundle/snipmate-snippets/snippets'
" Plugin key-mappings.
imap <C-k> <Plug>(neocomplcache_snippets_force_expand)
smap <C-k> <Plug>(neocomplcache_snippets_force_expand)
imap <C-l> <Plug>(neocomplcache_snippets_force_jump)
smap <C-l> <Plug>(neocomplcache_snippets_force_jump)
"}

"{ plugin minibufexplorerpp and its configuration
Plugin 'minibufexplorerpp'
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavAows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTaget = 1
"}

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
