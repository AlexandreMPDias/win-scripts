/** @param {{ onUndefined?: (key: string|number) => any } options */
function initOn(options) {
	const on = {
		undefined: options.onUndefined || (() => { })
	}
	return on;
}

class ProxyCache {
	static cacheKey = Symbol('cache');

	constructor(enabled) {
		this.enabled = enabled
	}

	updateSrc = (src) => this.src = src;

	/**
	 * @param {strign|number} key 
	 * @param {ReturnType<typeof initOn>} on
	 */
	getValue = (key, on) => {
		const cache = this.enabled ? this.cache : this.src;
		if (cache[key] === undefined) {
			cache[key] = on.undefined(key);
		}
		return cache[key];
	}

	get cache() {
		if (!this.src[ProxyCache.cacheKey]) {
			this.src[ProxyCache.cacheKey] = {};
		}
		return this.src[ProxyCache.cacheKey];
	}

}

/**
 * Wraps a object around a Proxy
 *
 * @type {<T>(source: T, options?: {
 * 	onUndefined?: (key: string|number) => T[keyof T]
 * 	cache?: boolean
 * }) => T}
 */
const proxify = (source, options = {}) => {
	const on = initOn(options);

	/** @type {ProxyCache} */
	const cache = new ProxyCache(options.cache);

	return new Proxy(source, {
		get: (target, key) => {
			cache.updateSrc(target);
			if (typeof key === 'string' || typeof key === 'number') {
				if (!target[key]) {
					return cache.getValue(key, on);
				}
			}
			return target[key];
		}
	})
}

const unproxify = (proxy) => JSON.parse(JSON.stringify(proxy));

module.exports = { proxify, unproxify };