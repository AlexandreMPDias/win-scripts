const { proxify } = require('../proxify')
const { fromConfig } = require('../get-config');
const { filterBadLines } = require('./filters')
const parse = require('./parse');

/**
 * 
 * @param {void}
 * 
 * @returns {Array<Record<'key'|'path'|'category', string>>}
 */
function getPathAsArray() {
  try {
    const raw = fromConfig.loadPathFile();
    const filtered = filterBadLines(raw);
    const parsed = parse(filtered);
    return parsed
  } catch (err) {
    console.error(`Unable to parse Path`);
    throw err;
  }
}

/**
 * 
 * 
 * @return {Array<{ name: string, paths: Array<Record<'key'|'path', string>> }>}
 */
function getGroupedByCategories() {
  const paths = getPathAsArray();
  const grouped = proxify({}, { onUndefined: (name) => ({ name, paths: [] }) })
  paths.forEach(({ category, ...path }) => {
    grouped[category].paths.push(path);
  });
  return Object.values(grouped);
}

module.exports = { get: getPathAsArray, getGroupedByCategories };
