
/**
 * @type {<T extends (args any) => any>(...transformations: T[]) => { on: (array: Parameters<T>[0]) => ReturnType<T> }}
 */
const pipe = (...transformations) => {
  return {
    on: (array) => transformations.reduce((last, transformation) => transformation(last), array)
  }
}

/** @type {(array: string[]) => string[]} */
const fixEndOfLine = (array) => array.map(row => row.replace(/\r\n$/, ''))

/** @type {(array: string[]) => string[]} */
const removeEmpty = (array) => array.filter(row => row.length);

/** @type {(array: string[]) => string[]} */
const removeComments = (array) => array.filter(row => !row.startsWith('//'))

/** @type {(array: string[]) => string[]} */
const filterBadLines = pipe(
  fixEndOfLine,
  removeComments,
  arr => arr.filter((row) => row.length > 2),
  arr => arr.map((row) => removeEmpty(row.split("::"))),
).on



module.exports = { filterBadLines };
