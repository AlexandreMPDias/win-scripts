const { polyfills } = require('../../helpers')
polyfills.load('chunkify', 'transpose', 'justify');


const getRow = (scripts, col) => {
	if (col <= 1) {
		return scripts.length;
	}
	return Math.floor((scripts.length) / (col)) + 1;
}

/**
 * 
 * @param {string[]} scripts 
 * @param {number} cols
 * 
 * @return {string[][]}
 */
const makeChunks = (scripts, cols) => {
	let chunks = [scripts]
	const rows = getRow(scripts, cols)
	chunks = scripts.chunk(rows).transpose();

	const colSizes = chunks.map(c => {
		return c.reduce((size, script) => {
			return Math.max(size, script.length)
		}, 0);
	});

	const colSize = Math.max(...colSizes) + 1;

	return chunks.map(c => c.map(script => script.padEnd(colSize, ' ')))
}

module.exports = makeChunks;