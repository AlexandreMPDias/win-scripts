/** @type {(array: [string, string]) => Array<Record<'key'|'path'|'category', string>>} */
module.exports = (array) => {
	let currentCategory = 'Uncategorized';

	return array.map(([key, path]) => {
		if (key.match(/# \w+/)) {
			currentCategory = key.slice(1).trim();
		}

		return {
			key,
			path,
			category: currentCategory
		}
	}).filter(({ path }) => path !== undefined)
}
