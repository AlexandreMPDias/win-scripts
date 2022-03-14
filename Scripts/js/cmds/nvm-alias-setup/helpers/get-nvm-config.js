const { fromConfig } = require('../../../helpers');

module.exports = {
	/**
	 * @returns {import('./types').NVMAliasConfig}
	 */
	getConfig: () => JSON.parse(fromConfig.load('nvm-alias.json')),
};
