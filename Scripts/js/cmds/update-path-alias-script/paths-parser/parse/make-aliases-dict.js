const { fn } = require('../../../../helpers');
const { PathAlias } = require('./path-alias');
const abort = require('../helper/abort');

/**
 * @param {readonly PathAlias[]} paths
 * @returns {Readonly<Record<string, PathAlias>>}
 *
 */
const makeAliasesDict = paths => {
	const dict = {};
	paths.forEach(path => {
		console.log(path);
		path.aliases.forEach(alias => {
			if (dict[alias]) {
				abort(`Duplicate alias [ ${alias} ] found`);
			}
			dict[alias] = path;
		});
	});
	return dict;
};

module.exports = makeAliasesDict;
