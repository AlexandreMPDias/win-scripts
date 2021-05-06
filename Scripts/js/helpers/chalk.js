
/**
 * @return {import('chalk').Chalk}
 */
const loadChalk = () => {
	try {
		const path = require('path');
		const nodePath = path.dirname(process.argv[0]);
		const chalkPath = path.join(nodePath, "node_modules", "chalk", "source", "index.js")
		return require(chalkPath)
	} catch {
		const { proxify } = require('./proxify');
		const chalk = proxify({}, {
			onUndefined: () => {
				const setColor = (s) => s;
				return Object.assign(setColor, chalk);
			},
			cache: true
		})
		return chalk;

	}
}

module.exports = loadChalk();