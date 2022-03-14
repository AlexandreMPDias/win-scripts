const fs = require('fs');

/**
 *
 * @param {import('./types').NVMLocation} location
 * @param {string} content
 */
function saveNVMAliasScript(location, content) {
	if (fs.existsSync(location.exec.nvm)) {
		fs.renameSync(location.exec.nvm, location.exec.realNvm);
	}

	fs.writeFileSync(location.exec.nvmScriptWrapper, content);
}

module.exports = { saveNVMAliasScript };
