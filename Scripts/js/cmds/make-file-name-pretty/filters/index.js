/**
 * @type {Array<(name: string) => boolean>}
 */
const filters = [
	(name) => !!name.match(/^.+\.com_[a-zA-Z0-9]+$/),
	(name) => !!name.match(/^\d+/),
]

/**
 * @type {Array<(name: import('../helpers/file').File) => boolean>}
 */
const hidden = [
	({ name, ext }) => name === 'desktop' && ext === '.ini'
]

/**
 * 
 * @param {Array<import('../helpers/file').File>} files
 * 
 * @return {Record<'rejected'|'accepted', Array<import('../helpers/file').File>>} 
 */
module.exports = function (files) {
	/**
	 * @type {Record<'rejected'|'accepted', Array<import('../helpers/file').File>>}
	 */
	const result = { accepted: [], rejected: [] };

	files.forEach(file => {
		if (hidden.some(f => f(file))) {
			return;
		}
		if (!filters.some(f => f(file.name))) {
			result.accepted.push(file);
		} else {
			result.rejected.push(file);
		}
	})

	return result;
}