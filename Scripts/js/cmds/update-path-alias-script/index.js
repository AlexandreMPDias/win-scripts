const { chalk, configPaths, polyfills, fromConfig } = require('../../helpers');
const { Batch } = require('./to-batch');
const parser = require('./paths-parser');
// polyfills.load("stringCut");

function main() {
	const pathMaps = parser.loadPathAlias();
	const { paths } = parser.parseContent(pathMaps);
	paths.forEach(path => {
		console.log(path);
	});
}

try {
	main();
} catch (err) {
	console.error(chalk.red(err.message));
	throw err;
	process.exit(1);
}
