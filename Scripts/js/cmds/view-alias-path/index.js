const { chalk, configPaths, polyfills, ascii, loadBooleanFlags } = require('../../helpers');
polyfills.load('stringCut');

const FLAG_CONFIG = [
	{ key: 'full-path', alias: 'f' },
	{ key: 'help', alias: 'h' },
];

const config = loadBooleanFlags(process.argv, FLAG_CONFIG);
let usingTextEllipsis = false;

const parsePath = (path, maxPathSize) => {
	if (config['full-path']) return path;
	const pathSize = ascii.stripASCIIStyle(path).length;
	if (pathSize < maxPathSize) return path;

	usingTextEllipsis = true;

	const max = Math.floor((maxPathSize - 2) / 2);
	const head = path.head(max);
	const tail = path.tail(max);

	return `${head}...${tail}`;
};

const writePath = (key, path, maxKeySize, maxRowSize) => {
	const tab = ' '.repeat(2);

	const pKey = `${tab}${chalk.cyan(key)}`;

	const indent = ' '.repeat(maxKeySize + 1 - key.length);

	const pPath = parsePath(path, maxRowSize - maxKeySize - 6);
	return `${pKey}: ${indent}${pPath}`;
};

function showHelp() {
	const colF = chalk.red;
	const colD = chalk.yellow;
	console.log(`Usage: [script-name] --list [${colF('options')}]`);
	console.log();
	console.log(`Options:`);
	console.log();
	console.log(`  ${colF('--help')}, ${colF('-h')}    ${colD('Show this help message')}`);
	console.log(
		`  ${colF('--full-path')}, ${colF('-f')}    ${colD('Show the full path of the alias')}`
	);
	console.log();
}

function main() {
	if (config.help) {
		return showHelp();
	}
	console.log();

	const categories = configPaths.getGroupedByCategories();

	const maxKeySize = categories.reduce(
		(catMax, { paths }) => paths.reduce((pMax, { key }) => Math.max(pMax, key.length), catMax),
		0
	);

	const maxRowSize = process.stdout.columns;

	categories.forEach(category => {
		const categoryName = category.name.replace(/^#\s*/, '');
		console.log(chalk.green(`[ ${categoryName} ]`));
		category.paths.forEach(({ path, key }) => {
			const prettyPath = path.replace(/(\{.+\})/, chalk.redBright(`$1`));
			console.log(writePath(key, prettyPath, maxKeySize, maxRowSize));
		});
		console.log();
	});

	if (usingTextEllipsis) {
		console.log(
			chalk.yellow(
				`Add ${chalk.red('--full-path')} or ${chalk.red(
					'-f'
				)} to see the full path of the alias`
			)
		);
	}
}

try {
	console.clear();
	main();
} catch (err) {
	console.error(chalk.red(err.message));
	process.exit(1);
}
