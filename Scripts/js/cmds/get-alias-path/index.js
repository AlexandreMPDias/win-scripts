const path = require("path");
const { chalk, getArgs, configPaths } = require('../../helpers');
const getResolvedPath = require("./get-resolved-path");


function parseInputAlias(aliasWithPath) {
	const [key, ...rest] = aliasWithPath.split(/\\|\//);
	return { key, rest: rest.join('/') };
}

function fixPath(any_path) {
	return any_path.split(/\\|\//).filter(x => x.length).join(path.sep);
}


function main() {
	const paths = configPaths.get();

	const aliasWithPath = getArgs(__dirname).join("/");


	const { key, rest } = parseInputAlias(aliasWithPath);

	const resolvedKeyPath = getResolvedPath(paths, key);

	const aliasedPath = fixPath(`${resolvedKeyPath}/${rest}`)

	// console.error(chalk.green(`Going to [ ${aliasedPath} ]`))
	process.stdout.write(aliasedPath)
}

// main();
try {
	main();
} catch (err) {
	console.error(chalk.red(err.message));
	process.exit(1);
}
