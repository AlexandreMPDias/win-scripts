const { log } = require('./log');
const { chalk, getArgs, configPaths } = require('../../helpers');
const { getResolvedPath } = require('./get-resolved-key-path');
const getAliasedPath = require('./get-aliased-path');

function parseInputAlias(aliasWithPath) {
	const [key, ...rest] = aliasWithPath.split(/\\|\//);
	return { key, rest: rest.join('/') };
}

function main() {
	const paths = configPaths.get();

	const aliasWithPath = getArgs(__dirname).join('/');

	const { key, rest } = parseInputAlias(aliasWithPath);

	const resolvedKeyPath = getResolvedPath(paths, key);

	log.info({ resolvedKeyPath });

	const aliasedPath = getAliasedPath(paths, `${resolvedKeyPath}/${rest}`);

	log.info(`Going to [ ${aliasedPath} ]`);
	process.stdout.write(aliasedPath);
}

try {
	main();
} catch (err) {
	console.error(chalk.red(err.message));
	process.exit(1);
}
