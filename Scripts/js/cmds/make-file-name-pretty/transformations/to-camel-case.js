/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {void}
 */
module.exports = function (file) {
	file.mutated = file.mutated.toLowerCase()
	file.transform(/(\s|\(|\{|\[)([a-z])/g, (_, a, b) => `${a}${b.toUpperCase()}`)
	file.mutated = file.mutated.charAt(0).toUpperCase() + file.mutated.slice(1)
	file.transform(/(\s)(\S{1,2})(\s)/g, g => g.toLowerCase());
}