class PathAlias {
	/**
	 * @param {string} groupBreadCrumb
	 * @param {import('../raw').Path.Obj} path
	 */
	constructor(groupBreadCrumb, path) {
		this.groupBreadCrumbBreadCrumb = groupBreadCrumb;
		this.aliases = path.aliases;
		this.path = path.path;
	}

	isValid = () => {
		return this.path.includes('{');
	};

	/**
	 * @param {Record<string, PathAlias>} aliases
	 */
	replaceShortcuts = aliases => {
		this.path = this.path.replace(/\{(\w+)\}/g, (_, alias) => {
			return aliases[alias].path;
		});
		return this.isValid();
	};
}

module.exports = { PathAlias };
