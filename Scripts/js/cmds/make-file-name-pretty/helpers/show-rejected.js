const { chalk } = require('../../../helpers');

/**
 * 
 * @param {Array<import('../helpers/file').File>} files
 * 
 * @return {void}
 */
function showRejected(files) {
	if (files.length === 0) {
		return;
	}
	console.log(chalk.red('Rejected Files:'));
	files.forEach(({ name, ext }) => {
		console.log(`  ${chalk.redBright(name)}${ext}`)
	})
	console.log();
}

module.exports = showRejected