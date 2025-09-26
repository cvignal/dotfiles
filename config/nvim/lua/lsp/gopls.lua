return {
	gopls = {
		ui = {
			codelenses = {
				generate = false,
				test = false,
				tidy = false,
				upgrade_dependency = false,
				vendor = false,
			},
			completion = {
				usePlaceholders = true,
			},
		},
		build = {
			directoryFilters = {
				"-**/bazel-bin",
				
				"-**/bazel-out",
				"-**/bazel-testlogs",
			},
		},
		completeUnimported = true,
		analyses = {
			unusedparams = true,
			unreachable = true,
		},
		staticcheck = true,
		gofumpt = true,
	},
}
