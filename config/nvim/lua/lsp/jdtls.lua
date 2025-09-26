local jdtls = require("jdtls")
local cache_vars = {}

local function get_jdtls_paths()
	if cache_vars.paths then
		return cache_vars.paths
	end

	local path = {}

	path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

	local jdtls_install = vim.fn.expand("$MASON/packages/jdtls")

	path.java_agent = jdtls_install .. "/lombok.jar"
	path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	if vim.fn.has("mac") == 1 then
		path.platform_config = jdtls_install .. "/config_mac"
	elseif vim.fn.has("unix") == 1 then
		path.platform_config = jdtls_install .. "/config_linux"
	elseif vim.fn.has("win32") == 1 then
		path.platform_config = jdtls_install .. "/config_win"
	end

	path.bundles = {}

	---
	-- Include java-test bundle if present
	---
	local java_test_path = vim.fn.expand("$MASON/packages/java-test")

	local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

	if java_test_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_test_bundle)
	end

	---
	-- Include java-debug-adapter bundle if present
	---
	local java_debug_path = vim.fn.expand("$MASON/packages/java-debug-adapter")

	local java_debug_bundle =
		vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")

	if java_debug_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_debug_bundle)
	end

	---
	-- Useful if you're starting jdtls with a Java version that's
	-- different from the one the project uses.
	---
	path.runtimes = {
		-- Note: the field `name` must be a valid `ExecutionEnvironment`,
		-- you can find the list here:
		-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		--
		-- This example assume you are using sdkman: https://sdkman.io
		{
			name = "JavaSE-21",
			path = vim.fn.expand("~/.sdkman/candidates/java/21.0.4-zulu"),
		},
	}

	cache_vars.paths = path

	return path
end

local path = get_jdtls_paths()
local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local cmd = {
	"java",

	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. path.java_agent,
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",

	"-jar",
	path.launcher_jar,

	"-configuration",
	path.platform_config,

	"-data",
	data_dir,
}
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

if cache_vars.capabilities == nil then
	jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	cache_vars.capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		ok_cmp and cmp_lsp.default_capabilities() or {}
	)
end

return {
	cmd = cmd,
	settings = {
		java = {
			-- jdt = {
			--   ls = {
			--     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
			--   }
			-- },
			project = {
				referencedLibraries = {
					-- add any library jars here for the lsp to pick them up
				},
			},
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = path.runtimes,
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				enabled = true,
				--parameterNames = {
				--   enabled = 'all' -- literals, all, none
				--}
			},
			format = {
				enabled = true,
				-- settings = {
				--   profile = 'asdf'
				-- },
			},
		},
		signatureHelp = {
			enabled = true,
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		contentProvider = {
			preferred = "fernflower",
		},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
		capabilities = cache_vars.capabilities,
	},
	init_options = {
		bundles = path.bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
}
