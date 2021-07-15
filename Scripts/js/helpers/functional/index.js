const pipe = (...transformations) => {
	return value => transformations.reduce((prev, t) => t(prev), value);
};

module.exports = {
	array: require('./array'),
	string: require('./string'),
	pipe,
};
