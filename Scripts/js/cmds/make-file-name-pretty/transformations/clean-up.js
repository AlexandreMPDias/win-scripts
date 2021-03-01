/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {void}
 */
module.exports = function (file) {
	file.mutated = file.mutated.replace(/\s+/g, ' ').trim();
}