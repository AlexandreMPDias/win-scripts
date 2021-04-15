module.exports = {
	polyfills: require('./polyfills'),
	chalk: require('./chalk'),
	...require('./get-arguments'),
	...require('./fs-list')
}