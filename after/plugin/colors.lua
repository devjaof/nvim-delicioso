require("rose-pine").setup({
  variant = "moon",
  styles = {
    bold = true,
    italic = true,
    transparency = false
  },
  groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
        },
    }
  }
)


function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
