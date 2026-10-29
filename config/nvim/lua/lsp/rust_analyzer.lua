return {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				disabled = { "unresolved-proc-macro" },
			},
			check = {
				extraArgs = { "--locked" },
			},
			cargo = {
				extraArgs = { "--locked" },
			},
		},
	},
}
