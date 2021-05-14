const { chalk } = require('../../helpers')
const ALIAS_DEBUG_MODE = Number(process.env.ALIAS_DEBUG_MODE) || 0;

const stringifyObject = (source) => {
	let parsed = JSON.stringify(source, null, "  ")
	parsed = parsed.replace(/(\s)\s*/g, '$1');
	parsed = parsed.replace(/"/g, '');
	parsed = parsed.replace(/\\\\/g, '\\');
	return parsed;
}

const parseValues = (values) => {
	return values.map(value => {
		if (typeof value === 'object') {
			return stringifyObject(value)
		}
		return String(value);
	}).join(' ') + '\n';
}

const paintMany = (color, values) => {
	if (!color) return values;
	return values.map(value => typeof value === 'object' ? value : color(value));
}

/**
 * 
 * @param {typeof chalk['blue'] | undefined} color 
 * 
 * @returns {(...values: any[]) => void}
 */
const write = (color) => {
	if (ALIAS_DEBUG_MODE === 1) {
		return (...values) => console.log(...paintMany(color, values));
	} else {
		return (...values) => { };
	}
}

const log = {
	info: write(chalk.cyan),
	warn: write(chalk.yellow),
	error: write(chalk.red),
}

write(chalk.underline.green, `ALIAS_DEBUG_MODE = ${ALIAS_DEBUG_MODE}`)

// if (ALIAS_DEBUG_MODE === 1) {
// 	console.log(chalk.underline.green('ALIAS_DEBUG_MODE = 1'));
// } else if (ALIAS_DEBUG_MODE === 2) {
// 	process.stderr.write(chalk.underline.green('ALIAS_DEBUG_MODE = 2') + '\n');
// }

module.exports = { log }