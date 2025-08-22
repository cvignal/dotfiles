return {
	filetypes = { "html", "elixir", "eelixir", "heex" },
	init_options = {
		userLanguages = {
			elixir = "html-eex",
			eelixir = "html-eex",
			heex = "html-eex",
		},
	},
	tailwindCSS = {
		experimental = {
			classRegex = {
				'class[:]\\s*"([^"]*)"',
			},
		},
	},
}
