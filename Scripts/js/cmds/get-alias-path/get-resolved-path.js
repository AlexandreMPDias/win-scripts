
/**
 * 
 * @param {Array<Record<'key'|'path', string>>} paths 
 * @param {string} key 
 * 
 * @return {string}
 */
function getResolvedPath(paths, key) {
	/** @type {Record<'key'|'path', string>|null} */
	let resolved = null

	function getResolvedPathStrict() {
		return paths.find(entry => entry === key);
	}

	resolved = getResolvedPathStrict();
	if (resolved) return resolved.path;

	function getNextClosestResolvedPath() {
		const matches = paths.filter(entry => {
			const original = [entry.key, key];
			const [left, right] = original.sort((a, b) => b.length - a.length);
			return left.match(right);
		});
		if (matches.length > 1) {
			throw new Error(`Too many alias found matching [ ${key} ]`)
		}
		return matches[0];
	}

	resolved = getNextClosestResolvedPath();
	if (resolved) return resolved.path;


	throw new Error(`Unknown alias [ ${key} ]`)
}

module.exports = getResolvedPath;