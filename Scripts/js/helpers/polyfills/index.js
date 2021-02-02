const loadPolyfills = {
	chunkify: () => require('./chunkify'),
	transpose: () => require('./transpose'),
	justify: () => require('./justify')
}

/**
 * 
 * @param  {Array<keyof typeof loadPolyfills>} keys
 * 
 * @return {void}
 */
const load = (...keys) => {
	keys.forEach(key => loadPolyfills[key]());
}


module.exports = {
	load
}