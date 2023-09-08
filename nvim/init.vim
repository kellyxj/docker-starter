call plug#begin()

Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } " scrollbar
Plug 'nvim-tree/nvim-tree.lua'						  " file explorer
Plug 'romgrk/barbar.nvim'							  " tabs
Plug 'nvim-tree/nvim-web-devicons'

Plug 'rmagatti/auto-session'						  " session manager
Plug 'ethanholz/nvim-lastplace'
Plug 'EtiamNullam/deferred-clipboard.nvim'			  " synchronize nvim clipboard with system clipboard
Plug 'sindrets/diffview.nvim'						  " git diff util

Plug 'numToStr/FTerm.nvim'							  " terminal
Plug 'Pocco81/auto-save.nvim'
Plug 'elihunter173/dirbuf.nvim'						  " edit file system from nvim

Plug 'itchyny/calendar.vim'
Plug 'vimwiki/vimwiki'

"lsp support"
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig' 
Plug 'dense-analysis/ale'

"debugger support"
Plug 'mfussenegger/nvim-dap'
Plug 'jay-babu/mason-nvim-dap.nvim'
Plug 'rcarriga/nvim-dap-ui'							  
Plug 'Weissle/persistent-breakpoints.nvim'

"folds"
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'anuvyklack/pretty-fold.nvim'
Plug 'vim-scripts/restore_view.vim'
Plug 'anuvyklack/keymap-amend.nvim'
Plug 'anuvyklack/fold-preview.nvim'

call plug#end()

lua require'mason'.setup{}
lua require'mason-lspconfig'.setup{ensure_installed = {"clangd", "pyright"},}
lua require'nvim-tree'.setup{hijack_directories = { enable = false }}
lua require'dapui'.setup {}
lua require'persistent-breakpoints'.setup{load_breakpoints_event = { "BufReadPost" },}
lua require'auto-session'.setup{}
lua require'nvim-lastplace'.setup{}
lua require'deferred-clipboard'.setup{fallback='unnamedplus',}
lua require'FTerm'.setup{}
lua require'pretty-fold'.setup{}
lua require'auto-save'.setup{}
lua require'dirbuf'.setup{}
lua require'fold-preview'.setup{}

lua << EOF

require('mason-nvim-dap').setup({
	ensure_installed = {"cppdbg", "python"},
	handlers = {
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end,	
	},
})

local dap = require('dap')
dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = vim.fn.exepath('OpenDebugAD7'),	
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " ")
		end,
		stopAtEntry = true,
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup({close_fold_kinds={},})
EOF

set mouse=a
set number											  "line numbers"
set cursorline						 
highlight CursorLine ctermbg=238					  "highlight current line"
highlight CursorLineNR ctermbg=238					  "highlight current line number" 
set foldlevelstart=99
set foldlevel=99
set tabstop=4
set shiftwidth=4
set softtabstop=4

lua vim.api.nvim_set_hl(0, "NormalFloat", {bg="#555555", fg="#555555"})
lua vim.api.nvim_set_hl(0, "FloatBorder", {bg="#FFBF00", fg="#FFBF00"})

"automatically write swap file to disk every 750ms"
set updatetime=750
set autoread                                                                                                                                                                                    
au CursorHold * checktime 

"keybindings"
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>
nnoremap <silent> <space> <Cmd>NvimTreeToggle<CR>

nnoremap <silent> <tab> <Cmd>BufferNext<CR>
nnoremap <silent> <S-tab> <Cmd>BufferPrevious<CR>

nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>

nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
nnoremap <silent>    <A-t> <Cmd>BufferRestore<CR>

nnoremap <silent> <Leader>b <Cmd>lua require'persistent-breakpoints.api'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>c <Cmd>lua require'persistent-breakpoints.api'.clear_all_breakpoints()<CR>

nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F9> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>

nnoremap <silent> <Leader>r <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <Leader>d <Cmd>lua require'dap'.disconnect({ terminateDebuggee = true })<CR>

nnoremap <silent> <Leader>l <Cmd> lua require'dapui'.float_element("scopes")<CR>
nnoremap <silent> <Leader>B <Cmd> lua require'dapui'.float_element("breakpoints")<CR>
nnoremap <silent> <Leader>s <Cmd> lua require'dapui'.float_element("stacks")<CR>
nnoremap <silent> <Leader>w <Cmd> lua require'dapui'.float_element("watches")<CR>
nnoremap <silent> <Leader>aw <Cmd> lua require'dapui'.elements.watches.add(vim.fn.input('Add watch: '))<CR>
nnoremap <silent> <Leader>e <Cmd> lua require'dapui'.eval(vim.fn.input('Expression to evaluate: '))<CR>

nnoremap <silent> <A-d> <Cmd>:ALEGoToDefinition<CR>
nnoremap <silent> <A-R> <Cmd>:ALEFindReferences<CR>

nnoremap <silent> <C-s> <Cmd>:SessionSave<CR>
nnoremap <silent> <C-R> <Cmd>:SessionRestore<CR>

nnoremap <silent> <A-{> <Cmd>:DiffviewOpen<CR>
nnoremap <silent> <A-H> <Cmd>:DiffviewFileHistory %<CR>
nnoremap <silent> <A-}> <Cmd>:DiffviewClose<CR>

nnoremap <silent> <A-T> <Cmd>lua require('FTerm').toggle()<CR>

nnoremap <silent> <Leader>f <Cmd>:Dirbuf<CR>

nnoremap <silent> zR <Cmd>lua require'ufo'.openAllFolds()<CR>
nnoremap <silent> zM <Cmd>lua require'ufo'.closeAllFolds()<CR>
nnoremap <silent> <Leader>z <Cmd> lua require'fold-preview'.toggle_preview()<CR>
