module.exports = {
	polyfills: require('./polyfills'),
	chalk: require('./chalk'),
	...require('./get-arguments'),
	...require('./fs-list'),
	...require('./get-config'),
	configPaths: require('./get-path'),
	...require('./range'),
	fn: require('./functional'),
	ascii: require('./ascii'),
};
