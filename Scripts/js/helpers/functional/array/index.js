const equals = (entries = []) => {
	if (entries.length === 0) {
		return true;
	}
	return entries.every(e1 => entries.every(e2 => e2 === e1));
};

/**
 * @type {{<T>(array: ReadonlyArray<T | readonly T[] | ReadonlyArray<T | readonly T[]> | ReadonlyArray<T | readonly T[] | ReadonlyArray<T | readonly T[]>>>) => T[]}
 */
const recursiveFlatten = array => {
	const is3D = array => array.some(item => Array.isArray(item));
	let outArray = Array.from(array);
	while (is3D(outArray)) {
		outArray = outArray.flat();
	}
	return outArray;
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

/**
 * @type {<T>(arrayOrNot: T) => arrayOrNot is Extract<T, readonly unknown[]>}
 */
const is = arrayOrNot => Array.isArray(arrayOrNot);

module.exports = {
	lens,
	len,
	unique,
	equals,
	filter,
	map,
	recursiveFlatten,
	is,
};
