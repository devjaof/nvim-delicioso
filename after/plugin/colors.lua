require("rose-pine").setup({
  variant = "moon",
  styles = {
    bold = true,
    italic = true,
    transparency = false
  },
  headings = "subtle"
})


function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
