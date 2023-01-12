const { chalk } = require('../../../../helpers');

class UnableToParsePathJSONError extends Error {
	constructor(message) {
		super(`Failed to validate paths.json file in config.\n${message}`);
	}
}

module.exports = function (message, ...moreMessages) {
	console.error(chalk.red(`Unable to parse paths.json file in config`));
	if (moreMessages.length > 0) {
		console.error(...moreMessages);
	}
	throw new UnableToParsePathJSONError(message);
};
