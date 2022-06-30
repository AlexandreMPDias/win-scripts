const { chalk } = require('../../helpers');
const scripts = require('./get-scripts');
const makeChunks = require('./makeChunks');

const chunks = makeChunks(scripts, undefined);

/**
 *
 * @param {string} word
 *
 * @return {string}
 */
const paint = word => {
	if (word.match(/config/)) {
		return word.replace(/(config)/, chalk.red('$1'));
	}
	if (word.match(/mv-\w+/) || word.match(/mts/)) {
		return chalk.yellow(word);
	}
	if (word.match(/edit/)) {
		return word.replace(/(edit)/, chalk.cyan('$1'));
	}
	return word;
};

const coloredRows = chunks.map(chunk => {
	const row = chunk.map(c => chalk.green(paint(c)));
	return row.join('');
});

if (coloredRows.length > 0) {
	console.log(coloredRows.join('\n'));
} else {
	console.log('Nothing matched your search criteria.');
}
