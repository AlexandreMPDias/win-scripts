const fs = require("fs");
const path = require("path");

const removeEmpty = (array) => array.filter(row => row.length);

const removeComments = (array) => array.filter(row => !row.startsWith('//'))

const pipe = (...transformations) => {
  return { on: (array) => transformations.reduce((next, transformation) => transformation(next), array) }
}

function readPathsFromFiles(pathsPath) {
  const raw = fs.readFileSync(pathsPath, { encoding: "utf-8" }).split(/(\r\n)|\n/g)
  const applyTransformations = pipe(
    removeComments,
    arr => arr.map((row) => removeEmpty(row.split("::"))),
    arr => arr.filter((row) => row.length > 1)
  )

  return applyTransformations.on(raw);
}

const goBack = (steps, append = "") => {
  const goBackStr = "../".repeat(steps);
  const outStr = `${__dirname}/${goBackStr}${append}`;
  return outStr.split("/").join(path.sep);
};

/**
 * 
 * @param {void}
 * 
 * @returns {Array<Record<'key'|'path', string>>}
 */
function getPathAsArray() {

  const rawPaths = readPathsFromFiles(goBack(3, "config/paths"))

  const applyTransformations = pipe(
    arr => arr.map(([key, aliasPath]) => ({ key, path: aliasPath }))
  )

  return applyTransformations.on(rawPaths);
}

module.exports = getPathAsArray;
