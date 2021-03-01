/**
 * 
 * @param {import('../helpers/file').File} file
 * 
 * @return {void}
 */
module.exports = function (file) {
	file.transform(/\[(.*?)\]/g, (_, g) => `[${g.trim()}]`).transform(/\[\]/g, '');
}