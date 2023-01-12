const { fromConfig } = require('../../../helpers');
const { validateJSONPath } = require('./validate');

function loadPathAlias() {
	const content = fromConfig.loadPathJSONFile();
	validateJSONPath(content);

	return content;
}

module.exports = { loadPathAlias };
