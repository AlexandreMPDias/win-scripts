/**
 * 
 * @type {import('./index').flagExtractor}
 */
const flagExtractor = ({ patterns, defaultValue, mutate, source }) => {
	/** @type {string} */
	const src = source || process.argv.slice(2).join(' ');
	let value = String(defaultValue);
	let replaced = false;

	const extractor = (_, match) => {
		value = match;
		replaced = true;
	}
	patterns.some(p => {
		src.replace(p, extractor);
		return replaced;
	})
	return mutate ? mutate(value) : value;
}

/**
 * @type {import('./index').flagExtractor}
 */
const booleanFlagExtractor = ({ patterns, source }) => {
	/** @type {string} */
	const src = source || process.argv.slice(2).join(' ');
	return Boolean(patterns.some(p => src.match(p)));
}

const createExtractor = (preArgs) => (args) => flagExtractor({ ...preArgs, ...args })

const extractFlag = {
	any: flagExtractor,
	number: createExtractor({ mutator: Number }),
	string: createExtractor({ mutator: String }),
	boolean: booleanFlagExtractor,
}


Object.assign(module.exports, { extractFlag })