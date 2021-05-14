const { log } = require('./log')

function wrapWithLog(name, cb) {
	return (paths, key) => {
		log.info(`[ ${name} match ]: attempting`);

		const match = cb(paths, key);

		if (match) {
			log.info(`[ ${name} match ]: found `, match);
		} else {
			log.warn(`[ ${name} match ]: not found`);
		}

		return match;
	}
}
class PathResolver {
	constructor(paths, key) {
		paths = paths;
		this.key = key;
	}

	/**
	 * 
	 * @param {Array<Record<'key'|'path'|'category', string>>} paths 
	 * @param {string} key 
	 * 
	 * @return {Record<'key'|'path'|'category', string>|null}
	 */
	getExactPath = (paths, key) => {
		// this.log.attempt("exact");
		const match = paths.find(entry => entry.key === key) || null;
		// this.log.result("exact", match);
		return match;
	}

	/**
	 * 
	 * @param {Array<Record<'key'|'path'|'category', string>>} paths 
	 * @param {string} key 
	 * 
	 * @return {Record<'key'|'path'|'category', string>|null}
	 */
	getNextClosestPath = (paths, key) => {
		// this.log.attempt("exact");

		// /**
		//  * @param {boolean} reverse 
		//  * 
		//  * @returns {Record<'key'|'path'|'category', string>[]}
		//  */
		//  const getUniDirectionalNextClosest = (reverse) => {
		// 	return paths.filter(entry => {
		// 		const original = [entry.key, key].map(x => x.toLowerCase());
		// 		const keys = original.sort((a, b) => b.length - a.length)
		// 		const [left, right] = reverse ? keys.reverse() : keys;
		// 		return left.match(right);
		// 	});
		// }

		// const straight = getUniDirectionalNextClosest();
		// const reversed = getUniDirectionalNextClosest(true);

		// if(straight.length === 1) {
		// 	return straight[0]
		// }
		// if(reversed.length === 1) {
		// 	return reversed[0];
		// }
		// if(reversed.length >= 1 || straight.length >= 1) {
		// 	this.throw(key, "Too many alias found matching {}");
		// }

		const matches = paths.filter(entry => {
			const original = [entry.key, key];
			const [left, right] = original.sort((a, b) => b.length - a.length).map(x => x.toLowerCase());
			return left.match(right);
		});
		if (matches.length > 1) {
			this.throw(key, "Too many alias found matching {}");
		}

		// this.log.result("next-closest", match);
		return matches[0] || null;
	}

	throw = (key, msg) => {
		throw new ReferenceError(msg.replace(/\{\}/g, `[ ${key} ]`));
	}


	/**
	 * 
	 * @param {Array<Record<'key'|'path'|'category', string>>} paths 
	 * @param {string} key 
	 * 
	 * @return {Record<'key'|'path'|'category', string>|null}
	 * 
	 */
	resolveAlias = (paths, key) => {
		/** @type {Record<'key'|'path'|'category', string>|null} */
		let resolved = null

		/** @type {Array<() => string|null>} */
		const resolveAttempts = [
			() => wrapWithLog("exact", this.getExactPath)(paths, key),
			() => wrapWithLog("next-closests", this.getNextClosestPath)(paths, key)
		];

		resolveAttempts.some(attempt => {
			resolved = attempt();
			return !!resolved;
		});

		return resolved;
	}

	/**
	 * 
	 * @param {Record<'key'|'path'|'category', string>|null} path 
	 * 
	 * @return {string}
	 * 
	 * @throws {ReferenceError} when the alias couldn't be resolved
	 */
	resolvePath = (paths, key) => {
		const resolved = this.resolveAlias(paths, key);

		if (!resolved) {
			this.throw(key, "Unknown alias {}");
		}

		return resolved.path;

	}

}


/**
 * 
 * @param {Array<Record<'key'|'path'|'category', string>>} paths 
 * @param {string} key 
 * 
 * @return {string}
 */
function getResolvedPath(paths, key) {
	const resolver = new PathResolver();

	return resolver.resolvePath(paths, key);
}

module.exports = {
	PathResolver,
	getResolvedPath
}
