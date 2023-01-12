class PathAlias {
	/**
	 * @param {string} alias
	 * @param {string} path
	 */
	constructor(alias, path) {
		this.path = path;
		this.alias = alias;
	}

	isValid = () => {
		return this.path.includes(/\{/);
	};

	/**
	 * @param {Record<string, PathAlias>} aliases
	 */
	replaceShortcut = aliases => {
		this.path = this.path.replace(/\{(\w+)\}/g, (_, alias) => {
			return aliases[alias].path;
		});
		return this.isValid();
	};
}

/** @param {string[]} content */
function parsePathAlias(content) {
	const maps = content.map(row => row.replace(/#.+/, '')).filter(Boolean);
}

module.exports = { PathAlias };
