const fs = require('fs');
const { chalk } = require('../../../helpers');

class RenameResult {
	/**
	 * 
	 * @param {import('../helpers/file').File} file 
	 * @param {NodeJS.ErrnoException|undefined} err 
	 */
	constructor(file, err) {
		this.file = file;
		this.success = !err;
		this.err = err;
	}
}

/**
 * 
 * @param {Array<import('../helpers/file').File>} files
 * 
 * @return {Array<import('../helpers/file').File>}
 */
function shouldRename(files) {
	return files.filter((file) => {
		const { origin, final } = file
		const should = origin !== final;

		if (!should) {
			console.warn(chalk.yellow(`skipping [${file.base}]`));
			console.warn(`  original file name is equal to output`)
		}
		return should;
	});
}

/**
 * 
 * @param {Array<import('../helpers/file').File>} files
 * 
 * @return {void}
 */
async function rename(files) {
	const filesToName = shouldRename(files);

	if (filesToName.length !== files.length) {
		console.log();
	}

	const results = await Promise.all(filesToName.map(renameSingle));

	/** @type {Array<RenameResult>} */
	const successes = [];

	/** @type {Array<RenameResult>} */
	const failures = [];

	results.forEach(result => {
		(result.success ? successes : failures).push(result);
	});

	successes.forEach(({ file }) => {
		console.log(`renamed`);
		console.log(`  ${chalk.yellow(file.base)}`);
		console.log(`  ${chalk.green(file.mutated + file.ext)}`);
		console.log();
	})

	failures.forEach(({ file, err }) => {
		console.log(`failed to rename file: ${chalk.redBright(file.base)}`);
		const message = (err && err.message ? err.message : err) || 'Unknown error'
		console.log(chalk.red('ERROR: '), message);
		console.log();

	});

	console.log(`[ ${chalk.cyanBright(successes.length)} ] files were renamed`);
}

/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {Promise<RenameResult>}
 */
async function renameSingle(file) {
	return new Promise((resolve) => {
		fs.rename(file.origin, file.final, function (err) {
			resolve(new RenameResult(file, err))
		});
	})
}

module.exports = { rename }