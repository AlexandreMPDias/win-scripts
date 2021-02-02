/** @type {string} */
const source = process.argv.slice(2).join(' ');

const { extractFlag } = require('./helpers/flag-extractor')

const flags = {
	size: extractFlag.number({
		patterns: [/-size=(\d+)/, /--s=(\d+)/],
		defaultValue: 30,
		source
	}),
	withoutSymbols: extractFlag.boolean({
		patterns: [/-without-symbol/, /--ws/],
		source
	}),
	withoutNumber: extractFlag.boolean({
		patterns: [/-without-number/, /--wn/],
		source
	}),
	help: extractFlag.boolean({
		patterns: [/-help/, /--h/],
		source
	})
}

if (flags.help) {
	console.log(`
	Get Token

	Parameters:
	--size, --s					size of the token
	--without-symbol, --ws		omit symbols in token
	--without-number, --wn		omit numbers in token

	Usage: 
		get-key <...flags>
	
	Example:
		get-key --s=30 --ws --wn

	`)
} else {



	const charLower = 'abcdefghijklmnopqrstuvwyz'.split('')
	const charUpper = charLower.map(x => x.toUpperCase())
	const symbols = '!@#$%&*;.,<>~'.split('')
	const numbers = "123456789".split('')

	/**
	 * 
	 * @type {<T>(array: T[]) => T} 
	 */
	const getRandomElement = (items) => items[Math.floor(Math.random() * items.length)]

	/**
	 * buildValidChars
	 * 
	 * @param {void}
	 * 
	 * @return {Array<string[]>}
	 */
	function buildValidChars() {
		const opts = [charLower, charUpper]
		if (!flags.withoutNumber) opts.push(numbers)
		if (!flags.withoutSymbols) opts.push(symbols);
		return opts;
	}

	/**
	 * buildToken
	 * 
	 * @param {Array<string[]>} opts
	 * 
	 * @return {string}
	 */
	function buildToken(opts) {
		return Array.from({ length: flags.size }).map(x => {
			const choice = getRandomElement(opts);
			const value = getRandomElement(choice)
			return value
		}).join('');
	}

	const token = buildToken(buildValidChars());

	console.log(token);

}