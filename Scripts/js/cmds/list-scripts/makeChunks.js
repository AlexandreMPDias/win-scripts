const { polyfills } = require('../../helpers');
polyfills.load('chunkify', 'transpose', 'justify');

const getRow = (scripts, col) => {
	if (col <= 1) {
		return scripts.length;
	}
	return Math.floor(scripts.length / col) + 1;
};

const getColSize = scripts => {
	return Math.max(...scripts.map(script => script.length)) + 1;
};

const getColNumber = (cols, maxChunkSize) => {
	if (cols !== undefined) return Number(cols);
	return Math.floor(process.stdout.columns / maxChunkSize);
};

/**
 *
 * @param {string[]} scripts
 * @param {number} cols
 *
 * @return {string[][]}
 */
const makeChunks = (scripts, cols) => {
	const maxColSize = getColSize(scripts);
	const colCount = getColNumber(cols, maxColSize);
	const rows = getRow(scripts, colCount);
	const colSize = getColSize(scripts);

	const chunks = [...scripts].chunk(rows).transpose();

	return chunks.map(c => c.map(script => script.padEnd(colSize, ' ')));
};

module.exports = makeChunks;
