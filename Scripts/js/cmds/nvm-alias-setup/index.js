const {
	chalk,
	getNVMLocation,
	saveNVMAliasScript,
	getConfig,
	NVMScriptBuilder,
} = require('./helpers');

/**
 *
 * @param {import('./helpers/types').NVMAliasConfig} config
 */
function writeAliasScriptContent(config) {
	const builder = new NVMScriptBuilder();

	const defaultAlias = config.default;
	const defaultVersion = config.aliases[defaultAlias];
	const aliasEntries = Object.entries(config.aliases);

	builder.ifCommand('use', cmdBuilder => {
		cmdBuilder.ifAlias('', ({ echo }) =>
			echo(`Using default alias [${defaultAlias}] for version [${defaultVersion}]`).nvm(
				`use ${defaultVersion}`
			)
		);

		aliasEntries.forEach(([alias, version]) => {
			cmdBuilder.ifAlias(alias, ({ echo }) =>
				echo(`Using alias [${alias}] for version [${version}]`).nvm(`use ${version}`)
			);
		});
	});

	builder.ifCommand('list', cmdBuilder =>
		cmdBuilder.if(
			`[%2] == [alias]`,
			true
		)(({ echo }) => {
			echo('Available aliases:').echo();
			aliasEntries.forEach(([alias, version]) => {
				echo(`v${version} ^(${alias}^)`);
			});
		})
	);

	builder.nvm('%*');

	return NVMScriptBuilder.compose(builder);
}

function main() {
	const nvmLocation = getNVMLocation();
	const config = getConfig();

	const scriptContent = writeAliasScriptContent(config);

	saveNVMAliasScript(nvmLocation, scriptContent);

	console.log(`nvm script at [${nvmLocation.pretty}] updated successfully`);
}

main();
