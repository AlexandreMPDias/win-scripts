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
	return values.map(value => typeof value === 'object' ? value : color(value));
}

const log = {
	info: (...values) => {
		if (ALIAS_DEBUG_MODE === 1) {
			console.log(...paintMany(chalk.cyan, values));
		}
		// else if (ALIAS_DEBUG_MODE === 2) {
		// 	const vs = parseValues(values);
		// 	process.stderr.write(chalk.cyan(vs));
		// }
	},
	warn: (...values) => {
		if (ALIAS_DEBUG_MODE) {
			const vs = parseValues(values);
			process.stderr.write(chalk.yellow(vs));
		}
	},
	error: (...values) => {
		if (ALIAS_DEBUG_MODE) {
			const vs = parseValues(values);
			process.stderr.write(chalk.red(vs) + '\n');
		}
	}
}

if (ALIAS_DEBUG_MODE === 1) {
	console.log(chalk.underline.green('ALIAS_DEBUG_MODE = 1'));
} else if (ALIAS_DEBUG_MODE === 2) {
	process.stderr.write(chalk.underline.green('ALIAS_DEBUG_MODE = 2') + '\n');
}

module.exports = { log }