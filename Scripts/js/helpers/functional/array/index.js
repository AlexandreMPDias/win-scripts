const equals = (entries = []) => {
	if (entries.length === 0) {
		return true;
	}
	return entries.every(e1 => entries.every(e2 => e2 === e1));
};

/**
 *
 * @type {{<K>(key: K) => <T>(entry:T, index: number) => T[K] }}
 */
const lens = key => (entry, index) => {
	if (typeof key === 'function') {
		return key(entry, index);
	}
	return entry[key];
};

/**
 *
 * @type {{<K>(key: K) => <T>(array: T[]) => T[K][] }}
 */
const len = key => array => {
	return array.map(lens(key));
};

const filter = predicate => array => array.filter(predicate);
const map = callbackFn => array => array.map(callbackFn);

/**
 * @type {{<T extends string|number>(array: T[]) => T[] }}
 */
const unique = array => {
	return Array.from(new Set(array));
};

module.exports = {
	lens,
	len,
	unique,
	equals,
	filter,
	map,
};
