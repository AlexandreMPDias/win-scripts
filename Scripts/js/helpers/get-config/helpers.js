const fs = require("fs");
const path = require("path");

/**
 * Load File from config directory
 * 
 * @param {string} relativeFilePath
 * @returns {string}
 */
function loadfromConfig(relativeFilePath) {
	const pathsPath = goBack(3, `config/${relativeFilePath}`);
	return fs.readFileSync(pathsPath, { encoding: "utf-8" })
}

/**
 * @param {number} steps 
 * @param {string} append 
 * @returns {string}
 */
const goBack = (steps, append = "") => {
	const goBackStr = "../".repeat(steps);
	const outStr = `${__dirname}/${goBackStr}${append}`;
	return outStr.split("/").join(path.sep);
};

module.exports = { goBack, loadfromConfig }