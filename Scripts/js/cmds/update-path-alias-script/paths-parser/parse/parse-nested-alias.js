const { PathAlias } = require('./path-alias');

const MAX_SEARCH_DEPTH = 5;

/**
 * @param {Readonly<Record<string, PathAlias>>} dict
 *
 */
const parseNestedAliases = dict => {
	const invalidPaths = new Set(Object.keys(dict));
	for (let i = 0; i < MAX_SEARCH_DEPTH; i++) {
		invalidPaths.forEach(alias => {
			const path = dict[alias];
			const isNowValid = path.replaceShortcuts(dict);
			if (isNowValid) {
				invalidPaths.delete(path.aliases);
			}
		});
		if (invalidPaths.size <= 0) return;
	}
};

module.exports = parseNestedAliases;
