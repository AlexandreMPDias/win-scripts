const { chalk, getArgs } = require('../../helpers');
const split = require('./split');

const getPatterns = (min, args) => {
	let patterns = split(min, args);

	const shouldAddNodeModules = args.some(arg => !arg.includes('/'));
	if (shouldAddNodeModules) {
		patterns = patterns.map(p => `**/node_modules/${p}`);
	}

	patterns = patterns.map(p => `${p}*`);

	return patterns;
};

/**
 *
 * @param {string[]} args
 */
function main(args) {
	console.log(chalk.cyan('input:') + '\n', args);

	const min = Math.min(...args.map(arg => arg.length));

	const patterns = getPatterns(min, args);

	const output = {};
	patterns.forEach(p => {
		output[p] = true;
	});

	console.log(JSON.stringify(output, null, '\t'));
}

main(getArgs(__dirname));
