const fs = require("fs");
const path = require("path");

function getPathAsArray() {
  const goBack = (steps, append = "") => {
    const goBackStr = "../".repeat(steps);
    const outStr = `${__dirname}/${goBackStr}${append}`;
    return outStr.split("/").join(path.sep);
  };

  const paths_path = goBack(3, "config/paths");

  const filterEmpty = (x) => x.length;

  const paths = fs
    .readFileSync(paths_path, { encoding: "utf-8" })
    .split("\n")
    .filter(filterEmpty)
    .map((row) => row.split("::").filter(filterEmpty))
    .map(([alias, p]) => [alias, p.replace(/\r$/, "")]);

  return paths.map(([key, aliasPath]) => ({ key, path: aliasPath }));
}

module.exports = getPathAsArray;
