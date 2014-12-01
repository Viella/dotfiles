"vimrc
set number
set autoindent
set clipboard=unnamed
set nocompatible
set shiftwidth=4
set showmatch
set smartindent
set incsearch
set hidden
set expandtab
set cursorline

colorscheme molokai
syntax enable
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
set tabstop=4
set noswapfile
set nobackup
set hlsearch

imap <c-j> <esc>
"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

NeoBundle"tyru/caw.vim"
NeoBundle "t9md/vim-quickhl"
NeoBundle "Shougo/neocomplete.vim"
"--------------------------------------------------------------------------
" caw.vim
" コメントアウトを切り替えるマッピング
" \c でカーソル行をコメントアウト
" 再度 \c でコメントアウトを解除
" 選択してから複数行の \c も可能
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

" \C でコメントアウトの解除
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

"--------------------------------------------------------------------------
" quickhl
" <Space>m でカーソル下の単語、もしくは選択した範囲のハイライトを行う
" 再度 <Space>m を行うとカーソル下のハイライトを解除する
" これは複数の単語のハイライトを行う事もできる
" <Space>M で全てのハイライトを解除する
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)


"--------------------------------------------------------------------------
" neocomplete
" 補完を有効にする
let g:neocomplete#enable_at_startup = 1

" 補完に時間がかかってもスキップしない
let g:neocomplete#skip_auto_completion_time = ""

"--------------------------------------------------------------------------
" neosnippet
NeoBundle "Shougo/neosnippet.vim"
" スニペットを展開するキーマッピング
" <Tab> で選択されているスニペットの展開を行う
" 選択されている候補がスニペットであれば展開し、
" それ以外であれば次の候補を選択する
" また、既にスニペットが展開されている場合は次のマークへと移動する
imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"


" 現在の filetype のスニペットを編集する為のキーマッピング
" こうしておくことでサッと編集や追加などを行うことができる
" 以下の設定では新しいタブでスニペットファイルを開く
nnoremap <Space>ns :execute "tabnew\|:NeoSnippetEdit ".&filetype<CR>


" スニペットファイルの保存ディレクトリを設定
let g:neosnippet#snippets_directory = "~/.neosnippet"

"--------------------------------------------------------------------------
" vimproc
" vimprocのインストールとbuild
" 自動でインストールしてビルド(make)してくれる
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\ 'windows' : 'make -f make_mingw32.mak',
\ 'cygwin' : 'make -f make_cygwin.mak',
\ 'mac' : 'make -f make_mac.mak',
\ 'unix' : 'make -f make_unix.mak',
\ },
\ }

"--------------------------------------------------------------------------
" quickrun
NeoBundle "thinca/vim-quickrun"
" vimproc.vim はプラグインの導入の他に C のコードをビルドする必要がある
" 'build' を設定する事で自動的に vimproc.vim がビルドされる
" また Kaoriya 版 Vim を使用している場合は vimproc.vim が同梱されているので
" プラグインを導入する必要はない
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

" 設定例
" 出力先
" 成功した場合：quickrun 専用の出力バッファ
" 失敗した場合：quickfix を :copen で開く
" バッファの開き方：botright 8sp
"
" コマンドの実行は vimproc.vim を使用する
" runner に vimproc を設定
" runner/vimproc/updatetime には更新するタイミングを設定
" この値が大きいとコンパイルが終了していても
" 結果が出力されるまでに時間がかかる可能性がある。
"
" cpp.type にて使用するコンパイラなどを設定する
" cpp.cmdopt にコマンドラインオプションを設定

let g:quickrun_config = {
\   "_" : {
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/quickfix/open_cmd" : "copen",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 500,
\   },
\   "cpp" : {
\       "type" : "cpp/clang++",
\       "cmdopt" : "-std=c++1y -ID:/home/cpp/boost/boost_1_55_0",
\   },
\}

" :QuickRun 時に quickfix の中身をクリアする
" こうしておかないと quickfix の中身が残ったままになってしまうため
let s:hook = {
\   "name" : "clear_quickfix",
\   "kind" : "hook",
\}

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

" call quickrun#module#register(s:hook, 1)
" unlet s:hook


NeoBundle 'mattn/emmet-vim'
