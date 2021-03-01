const split = require('./split');

const others = [
	require('./remove-banned-words'),
	require('./remove-brackets'),
	require('./alias'),
	require('./to-camel-case'),
]

const cleanUp = require('./clean-up');

/**
 * 
 * @param {Array<import('../helpers/file').File>} files
 * 
 * @return {void}
 */
module.exports = function (files) {

	files.forEach(file => {
		split(file);

		others.forEach(other => other(file))

		cleanUp(file)
	})

}