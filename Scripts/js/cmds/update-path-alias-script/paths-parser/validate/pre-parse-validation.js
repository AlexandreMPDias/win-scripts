const { makeAborter, makeValidate } = require('./helpers');
const { fn } = require('../../../../helpers');

const KEYS = {
	PATH: {
		KNOWN: ['path', 'paths', 'aliases'],
		REQUIRED: ['aliases', 'path'],
	},
	GROUP: {
		KNOWN: ['name', 'paths'],
		REQUIRED: ['name', 'paths'],
	},
};

/**
 * @param {import('../raw').File} content : ;
 */
function validateJSONPath(content) {
	const validate = makeValidate();

	function validateAliases(aliases, path) {
		if (Array.isArray(aliases)) {
			if (aliases.length === 0) {
				makeAborter(path)('cannot be empty');
			}
			validate.every(path, aliases, validate.primitive);
		} else {
			validate.primitive(path, aliases, false);
		}
	}

	/**
	 * @param {import('../raw').Path[]} values
	 * @param {string} path
	 */
	function validateArrayOfPaths(values, path) {
		values.forEach((element, index) => {
			const subPath = `${path}.paths[${index}]`;
			validatePath(element, subPath, true);
		});
	}

	/**
	 * @param {import('../raw').Path} values
	 * @param {string} path
	 */
	function validatePath(values, path) {
		const abort = makeAborter(values);
		validate.object(path, values, false, abort);
		if (fn.array.is(values)) {
			if (values.length !== 2) {
				abort(`must be an array of exactly two elements`);
			}
			const [aliasOrAliases, pathMappedValue] = values;
			validate.string([path, 1], pathMappedValue, false);
			validateAliases(aliasOrAliases, `${path}[0]`);
		} else {
			validate.knownProps(path, values, KEYS.PATH.KNOWN);
			validate.requiredProps(path, values, KEYS.PATH.REQUIRED);

			validateAliases(values.aliases, `${path}.aliases`);
			validate.string([path, 'path'], values.path, false);

			validate.array([path, 'paths'], values.paths, true);
			if (values.paths) {
				validateArrayOfPaths(values.paths, path);
			}
		}
	}

	/**
	 * @param {import('../raw').Group} group
	 * @param {string} path
	 */
	function validateGroup(group, path) {
		validate.knownProps(path, group, KEYS.GROUP.KNOWN);
		validate.requiredProps(path, group, KEYS.GROUP.REQUIRED);

		validate.string([path, 'name'], group.name);
		validate.arrayOfDicts([path, 'paths'], group.paths);
		validateArrayOfPaths(group.paths, path);
	}

	validate.arrayOfDicts('paths', content.paths, true);
	validate.arrayOfDicts('groups', content.groups, true);

	content.groups?.forEach((group, index) => validateGroup(group, `groups[${index}]`));
	content.paths?.forEach((path, index) => validatePath(path, `paths[${index}]`));
}

module.exports = { validateJSONPath };
