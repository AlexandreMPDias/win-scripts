const lensIndex = (offset, step) => (_, i) => {
  return i * step + offset;
};

/**
 * @type {{
 * 	(size: number) => number[];
 * 	(start: number, end: number, step?: number) => number[];
 * }}
 */
const range = (...args) => {
  if (args.length === 1) {
    const [length] = args;
    return Array.from({ length }).map(lensIndex(0, 1));
  }

  const [start, end, step = 1] = args;

  const length = 1 + end - start;

  return Array.from({ length }).map(lensIndex(start, step));
};

module.exports = { range };
