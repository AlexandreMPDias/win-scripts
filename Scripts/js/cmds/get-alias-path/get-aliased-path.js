const { sep } = require("path");
const { log } = require('./log');
const { PathResolver } = require("./get-resolved-key-path");

class PathAliasResolver {

	/**
	 * @param {string} keyPath 
	 */
	constructor(paths, keyPath) {
		this.resolverPaths = paths;
		this.path = this.fixSep(keyPath);

		/** @type {string[]} */
		this.inner = [];
	}


	parseInnerAlias = () => {
		const inner = this.path.match(/\{\w*\}/g).map(String);

		if (inner.length === 0) return;

		const resolver = new PathResolver();

		const resolveAlias = (aliasKey) => resolver.resolvePath(this.resolverPaths, aliasKey.slice(1, -1))

		this.path = inner.reduce((path, aliasKey) => path.replace(aliasKey, resolveAlias(aliasKey)), this.path);
	}

	/**
	 * @param {string} path 
	 * @returns {string}
	 */
	fixSep = (path) => {
		/** @type {Array<(value: string) => string>} */
		const changes = [
			// Changes the separator to ['/'] (just to make next changes easy)
			(value) => value.replace(/\\/g, '/'),

			// Without Double separator
			(value) => value.replace(/\/\//g, '/'),

			// Without ending separator
			(value) => value.replace(/\/$/, ''),

			// Change back to the correct separator
			value => value.replace(/\//g, sep)
		]
		return changes.reduce((prevValue, change) => change(prevValue), path);
	}


	/**
	 * @returns {string}
	 */
	resolve = () => {
		this.parseInnerAlias();


		return this.fixSep(this.path);
	}

}

module.exports = (paths, keyPath) => {
	const aliasResolver = new PathAliasResolver(paths, keyPath);

	return aliasResolver.resolve();
}