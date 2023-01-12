const loadFile = require('./helpers');
const { goBack, loadfromConfig } = loadFile;

/**
 * Load paths from config directory
 *
 * @param {void}
 * @returns {string[]}
 */
function loadPathFile() {
	return loadfromConfig('paths').split(/(\r\n)|\n/g);
}

/**
 * Load paths from config directory
 *
 * @param {void}
 * @returns {any}
 */
function loadPathJSONFile() {
	return JSON.parse(loadfromConfig('paths.json'));
}

/**
 * Load script-categories.json from config directory
 *
 * @param {void}
 * @returns {string[]}
 */
function loadCategoriesFile() {
	return JSON.parse(loadfromConfig('script-categories.json'));
}

const fromConfig = {
	loadPathFile,
	loadPathJSONFile,
	loadCategoriesFile,
	load: loadfromConfig,
};

module.exports = { fromConfig, goBack };
