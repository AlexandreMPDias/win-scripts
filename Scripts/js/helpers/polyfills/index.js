const loadPolyfills = {
	chunkify: () => require('./chunkify'),
	transpose: () => require('./transpose'),
	justify: () => require('./justify'),
	stringCut: () => require('./string-cut')
}

/**
 * 
 * @param  {Array<keyof typeof loadPolyfills>} keys
 * 
 * @return {void}
 */
const load = (...keys) => {
	keys.forEach(key => {
		try {
			loadPolyfills[key]()
		} catch (err) {
			console.error(`Unable to load [ ${key} ]`);
			throw err;
		}
	});
}


module.exports = {
	load
}