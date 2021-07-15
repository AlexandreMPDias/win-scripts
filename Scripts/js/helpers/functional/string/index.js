/**
 * @type {{[K in keyof string]: string[K] extends (...args: infer A) => any ?
 * 	(...args: A) => (value: string) => ReturnType<string[K]>
 * :
 * () => (value: string) => string[K]
 * }}
 */
const fnStringProxy = new Proxy(
	{},
	{
		get: (_, key) => {
			return (...args) =>
				string => {
					if (typeof string[key] === 'function') {
						return string[key](...args);
					}
					return string[key];
				};
		},
	}
);

module.exports = fnStringProxy;
