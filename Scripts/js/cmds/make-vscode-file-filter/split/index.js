const { range, fn } = require('../../../helpers');

const order = (pair, ...transformations) => {
	const [a, b] = transformations.reduce((tPair, t) => tPair.map(t), pair);
	return a > b ? 1 : -1;
};

/**
 * @returns {string[]}
 */
const StrArray = a => a;

const makeExclude = letters => {
	return `[^${letters.join('')}]`;
};

class Splitter {
	constructor(min, args) {
		this.min = Number(min);
		this.args = StrArray(args);

		/** @type {Array<[string, string]>} */
		this.cache = [];
	}

	__add = (letters, index) => {
		const nextCache = [];

		const onEachLetter = (entry = '') => {
			letters.forEach(letter => {
				const newEntry = entry + letter;
				nextCache.push([newEntry, this.__makeExcludePattern(entry, index)]);
			});
		};

		const cache = this.cache.filter(([cEntry]) => cEntry.length === index);

		if (cache.length) {
			cache.forEach(([entry]) => onEachLetter(entry));
		} else {
			onEachLetter();
		}

		this.cache = fn.array.unique(this.cache.concat(nextCache));
		this.cache = this.cache.filter(([entry]) => {
			return this.args.some(arg => arg.startsWith(entry));
		});
	};

	__makeExcludePattern = (entry, index) => {
		const letters = fn.pipe(
			fn.array.filter(fn.string.startsWith(entry)),
			fn.array.map(fn.array.lens(index)),
			fn.array.unique
		)(this.args);

		return makeExclude(letters);
	};

	__extractLetters = index => {
		const letters = this.args.map(fn.array.lens(index));
		return Array.from(new Set(letters));
	};

	process = () => {
		range(this.min).forEach(index => {
			const letters = this.__extractLetters(index);
			this.__add(letters, index);
			// console.log({ letters, cache: this.cache.map(fn.array.lens(0)) });
		});

		this.cache.sort(([e1], [e2]) => {
			const pair = [e1, e2];
			const lengths = pair.map(fn.array.lens('length'));
			return fn.array.equals(lengths) ? order(pair) : order(pair, fn.array.lens('length'));
		});

		const result = this.cache.map(([entry, exclude]) => entry.slice(0, -1) + exclude);

		return result;
	};
}

/**
 *
 * @param {number} min
 * @param {string[]} args
 * @returns {string[]}
 */
const split = (min, args) => {
	const splitter = new Splitter(min, args);

	return splitter.process();
};

module.exports = split;
