const path = require('path');

class File {
	/**
	 * 
	 * @param {string} filePath 
	 */
	constructor(origin) {
		this.origin = origin;

		const parsed = path.parse(origin);

		this.base = parsed.base;
		this.dir = parsed.dir;
		this.name = parsed.name;
		this.ext = parsed.ext;
		this.mutated = this.name;
	}

	/**
	 * Apply transformation to mutated property
	 * 
	 * @param {RegExp|string} pattern
	 * @param {string|((...args: string[]) => string)|undefined} replace
	 * 
	 * @return {File}
	 */
	transform = (pattern, replace = '') => {
		this.mutated = this.mutated.replace(pattern, replace)
		return this;
	}

	/**
	 * Apply many transformations to mutated property
	 * 
	 * @param  {...Array<[pattern: RegExp, replace: string|((...args: string[]) => string)] | [pattern: RegExp]>} pairs 
	 * 
	 * @return {File}
	 */
	transformMany = (...pairs) => {
		pairs.forEach(([pattern, replace]) => {
			this.transform(pattern, replace)
		});
		return this;
	}

	get final() {
		return `${path.join(this.dir, this.mutated)}${this.ext}`
	}

	toString = () => {
		const {
			origin, name, ext, mutated, final
		} = this;
		return {
			origin, name, ext, mutated, final
		}
	}
}

module.exports = {
	File
}