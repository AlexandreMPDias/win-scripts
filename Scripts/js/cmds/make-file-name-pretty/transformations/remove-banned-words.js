/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {void}
 */
module.exports = function (file) {
	/**
	 * @type {Array<RegExp>}
	 */
	const patterns = [
		/\ssub/i,
		/\sUNCEN\S*/i,
		/\d{3,4}x\d{3,4}/g,
		/\s(1080|720|480)p?/i,
		/Dual/,
		/BD/,
		/AVC|V1x/i,
		/\d+bit/,
		/FHD|HD|UHD/
	];

	file.transformMany(...patterns.map(p => [p]))
}