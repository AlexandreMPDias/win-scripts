const { chalk, configPaths, polyfills } = require('../../helpers');
polyfills.load("stringCut");

const parsePath = (path, maxPathSize) => {
	if (path.length < maxPathSize) return path;

	const max = Math.floor((maxPathSize - 2) / 2);
	const head = path.head(max);
	const tail = path.tail(max);

	return `${head}...${tail}`
}

const writePath = (key, path, maxKeySize, maxRowSize) => {
	const tab = " ".repeat(2);

	const pKey = `${tab}${chalk.cyan(key)}`

	const indent = ' '.repeat(maxKeySize + 1 - key.length)

	const pPath = parsePath(path, maxRowSize - maxKeySize - 6);
	return `${pKey}: ${indent}${pPath}`

}

function main() {
	console.log();

	const categories = configPaths.getGroupedByCategories();

	const maxKeySize = categories.reduce((catMax, { paths }) => paths.reduce(((pMax, { key }) => Math.max(pMax, key.length)), catMax), 0)

	const maxRowSize = process.stdout.columns;

	categories.forEach((category) => {
		console.log(chalk.green(`[ ${category.name} ]`));
		category.paths.forEach(({ path, key }) => {
			console.log(writePath(key, path, maxKeySize, maxRowSize))
		});
		console.log();
	})
}

try {
	main();
} catch (err) {
	console.error(chalk.red(err.message));
	process.exit(1);
}
