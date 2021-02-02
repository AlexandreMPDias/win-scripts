class CacheHelper {
	constructor(src) {
		this.src = src;
	}

	makeKey = (key) => `__$$cache__${key}`

	getValue = (key) => {
		return this.src[this.makeKey(key)];
	}

	assign = (key, value) => {
		this.src[this.makeKey(key)] = value;
	}

	exists = (key) => {
		return this.makeKey(key) in this.src;
	}

}

/**
 * Wraps a object around a Proxy
 * 
 * @param {object} source 
 * @param {{
 * 	onUndefined: (key: string|number) => any
 * 	cache?: boolean
 * }} options 
 */
const proxify = (source, options) => {
	return new Proxy(source, {
		get: (target, key) => {
			if (!target[key] && (typeof key === 'string' || typeof key === 'number')) {
				if (options.cache) {
					const cache = new CacheHelper(target);
					if (!cache.exists(key)) {
						const value = options.onUndefined(key);
						cache.assign(key, value);
						return value;
					}
					return options.onUndefined(key);
				}
			}
		}
	})
}

module.exports = proxify;