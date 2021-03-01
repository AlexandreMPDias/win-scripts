/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {void}
 */
module.exports = function (file) {
	file.transformMany(
		[/\s/g, ' '],
		[/\.|_|\+/g, ' '],
		[/\s-\s/g, '___'],
		[/-/g, ' '],
		[/___/g, ' - ']
	)
}