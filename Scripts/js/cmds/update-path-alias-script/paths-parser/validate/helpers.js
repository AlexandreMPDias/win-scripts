const baseAbort = require('../helper/abort');

const makeAborter = key => message => baseAbort(`[${key}] ${message}`);

const makeValidate = () => {
	/**
	 * @type {<A extends any[], R>(callback: (path: string, ...args: A) => R) => (path: string[]|string, ...args: A) => R}
	 */
	const handlePath =
		callback =>
		(path, ...args) => {
			if (Array.isArray(path)) {
				path = path
					.map(p => (typeof p === 'number' ? `[${p}]` : p))
					.join('.')
					.replace(/\.(\[)/g, '[');
			}
			// if (typeof args[0] !== 'object' && typeof args[0] !== 'function') {
			// 	console.log(`> [${callback.name}]`, path, `{${args[0]}}`);
			// }
			return callback(path, ...args);
		};
	const validateUndefined = (path, value, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		if (!value) {
			if (optional) return;
			abort(`cannot be undefined`);
		}
	};
	const validateArray = (path, array, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, array, optional, abort);
		if (array === undefined) return;
		if (Array.isArray(array)) return;
		abort(`must be a valid array`);
	};
	const validatePrimitive = (path, value, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, value, optional, abort);
		if (value === undefined) return;
		if (typeof value !== 'string' && typeof value !== 'number')
			abort(`must be a valid string or number. Type ${typeof value} found`);
	};
	const validateString = (path, value, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, value, optional, abort);
		if (value === undefined) return;
		if (typeof value !== 'string') abort(`must be a valid string`);
	};
	const validateDict = (path, dict, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, dict, optional, abort);
		if (dict === undefined) return;
		if (typeof dict !== 'object' && !Array.isArray(dict)) abort(`must be a valid object`);
	};
	const validateObject = (path, obj, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, obj, optional, abort);
		if (obj === undefined) return;
		if (typeof obj !== 'object') abort(`must be a valid object or array`);
	};
	const validateArrayOfDicts = (path, array, optional = false, abort = null) => {
		abort = abort || makeAborter(path);
		validateUndefined(path, array, optional, abort);
		validateArray(path, array, optional, abort);
		array?.some((element, index) => validateDict(`${path}[${index}]`, element, false));
	};
	const validateEvery = (path, array, callback) => {
		const abort = makeAborter(path);
		validateUndefined(path, array, false, abort);
		validateArray(path, array, false, abort);
		array.forEach((value, index) => {
			const subPath = `${path}[${index}]`;
			const abort = makeAborter(`${path}[${index}]`);
			callback(subPath, value, false, abort);
		});
	};
	const validateRequiredProps = (path, obj, props, abort = null) => {
		abort = abort || makeAborter(path);
		props.forEach(prop => {
			if (obj[prop] === undefined) {
				abort(`is missing property [${prop}]`);
			}
		});
	};
	const validateKnownProps = (path, obj, props, abort = null) => {
		abort = abort || makeAborter(path);
		const objectKeysSet = new Set(Object.keys(obj));
		props.forEach(propKey => objectKeysSet.delete(propKey));
		if (objectKeysSet.size > 0) {
			const unknownKeys = Array.from(objectKeysSet).join(', ');
			abort(`unknown keys found [ ${unknownKeys} ]`);
		}
	};
	return {
		undefined: handlePath(validateUndefined),
		array: handlePath(validateArray),
		object: handlePath(validateObject),
		dict: handlePath(validateDict),
		arrayOfDicts: handlePath(validateArrayOfDicts),
		primitive: handlePath(validatePrimitive),
		string: handlePath(validateString),
		every: handlePath(validateEvery),
		requiredProps: handlePath(validateRequiredProps),
		knownProps: handlePath(validateKnownProps),
	};
};

module.exports = { makeAborter, makeValidate };
