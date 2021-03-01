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
		[/Ep\S*\s?(\d+)/i, 'ep$1'],
	];

	file.transformMany(...patterns)
}