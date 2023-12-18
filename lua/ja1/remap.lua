vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- salvar no ctrl s`
vim.keymap.set({"n", "i"}, "<C-s>", vim.cmd.w)

-- mover o código selecionado
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append da linha abaixo na de cima sem mover o cursor
vim.keymap.set("n", "J", "mzJ`z")

-- melhora a movimentação
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- melhora o highlight da busca
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- o que foi copiado não é perdido ao fazer umm highlight de algo e colar
-- o que foi anteriormente copiado
vim.keymap.set("x", "<leader>p", [["_dP]])

-- faz com que o que foi copiado no yank seja armazenado no clipboard do
-- sistema tbm, ou seja, o que foi copiado no vim pode ser dado ctrl v
-- emm outro lugar
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- é muito ruim ter que apertar esc, ctrl-c é mais facil
vim.keymap.set("i", "<C-c>", "<Esc>")

-- mata o Q
vim.keymap.set("n", "Q", "<nop>")

-- mmacros
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


-- melhora a navegacao
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- o melhor remap de todos
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

