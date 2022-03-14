const { chalk } = require('../../../helpers');

module.exports = {
	chalk,
	...require('./get-nvm-location'),
	...require('./save-nvm-alias-script'),
	...require('./get-nvm-config'),
	...require('./script-builder'),
};
