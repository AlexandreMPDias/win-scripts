const { chalk } = require('../../../helpers');
const chdir = require('child_process');
const path = require('path');

module.exports = {
	/**
	 * @returns {import('./types').NVMLocation}
	 */
	getNVMLocation: () => {
		const nvmExecPath = chdir.execSync('whereis nvm').toString().trim();

		const nvmLocationParts = nvmExecPath.split(path.sep);
		nvmLocationParts.pop();

		const clean = nvmLocationParts.join('/');
		const osSpecificPath = nvmLocationParts.join(path.sep);

		return {
			clean: clean,
			pretty: chalk.green(clean),
			path: osSpecificPath,
			exec: {
				nvm: path.join(osSpecificPath, 'nvm.exe'),
				realNvm: path.join(osSpecificPath, 'real-nvm.exe'),
				nvmScriptWrapper: path.join(osSpecificPath, 'nvm.bat'),
			},
		};
	},
};
