const { fn } = require('../../../../helpers');
const { PathAlias } = require('./path-alias');
const makeAliasesDict = require('./make-aliases-dict');
const parseNestedAliases = require('./parse-nested-alias');

/**
 * @type {<T>(arrayOrNot: T|T[]|readonly T[]) => T[]}
 */
const forceArray = value => (Array.isArray(value) ? value : [value].filter(Boolean));

/**
 * @param {import('../raw').Path} path
 * @return {import('../raw').Path.Obj}
 */
const resolvePathValues = path => {
	if (fn.array.is(path)) {
		const [aliasOrAliases, pathValue] = path;
		const aliases = forceArray(aliasOrAliases);
		return {
			aliases,
			path: pathValue,
			paths: [],
		};
	}
	return path;
};

/**
 * @param {import('../raw').Path} rawPath
 * @param {string} groupBreadCrumb
 *
 * @return {ReadonlyArray<PathAlias | ReadonlyArray<PathAlias>>}
 */
const partialParsePathRecursive = (rawPath, groupBreadCrumb = '') => {
	const path = resolvePathValues(rawPath);

	const pathAlias = new PathAlias(groupBreadCrumb, path);

	if (!path.paths) {
		return [pathAlias];
	}
	const subPaths = path.paths.map(path => partialParsePathRecursive(path, groupBreadCrumb));

	return [pathAlias, ...subPaths];
};

/**
 * @param {import('../raw').Group} group
 * @param {string} groupBreadCrumb
 *
 * @return {ReadonlyArray<PathAlias | ReadonlyArray<PathAlias>>}
 */
const partialParseGroup = (group, groupBreadCrumb = '') => {
	const breadcrump = [groupBreadCrumb, group.name].filter(Boolean).join(' > ');
	return group.paths.map(path => partialParsePathRecursive(path, breadcrump));
};

/**
 * @param {import('../raw').File} content
 *
 * @return {import('../types').Content}
 */
const parseContent = content => {
	const pathAliasesChunked = [];
	if (content.paths) {
		pathAliasesChunked.push(...partialParseGroup({ name: null, paths: content.paths }));
	}
	if (content.groups) {
		pathAliasesChunked.push(...content.groups.map(group => partialParseGroup(group)));
	}
	const pathAlias = fn.array.recursiveFlatten(pathAliasesChunked);
	console.log(pathAlias);

	const dict = makeAliasesDict(pathAlias);
	parseNestedAliases(dict);

	const contentPaths = Object.entries(dict).map(([alias, path]) => {
		return {
			group: path.groupBreadCrumbBreadCrumb,
			path: path.path,
			alias,
		};
	});

	return {
		paths: contentPaths,
	};
};

module.exports = { parseContent };
