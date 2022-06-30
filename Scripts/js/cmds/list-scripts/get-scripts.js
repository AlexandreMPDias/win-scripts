const fs = require('fs');
const path = require('path');
const { deprecated } = require('./assets');
const bin = path.resolve(path.join(path.dirname(process.argv[1]), '..', '..', '..', 'bin'));

const matches = process.argv[2];

const load = () => {
	return fs.readdirSync(bin, { encoding: 'utf-8' });
};

const filterPrivate = scripts => {
	return scripts.filter(s => !s.match(/^_/));
};

const filterDeprecatedCommands = scripts => {
	return scripts.filter(script => {
		const str = path.parse(script).name;
		const result = !deprecated.some(pattern => str.match(pattern));
		return result;
	});
};

const removeExtension = scripts => {
	return scripts.map(s => path.parse(s).name);
};

const filterUnique = scripts => {
	const set = new Set(scripts);
	return Array.from(set);
};

const filterParametersMatch = scripts => {
	if (!matches) return scripts;
	console.log(`Listing scripts that match: ${matches}\n`);
	return scripts.filter(s => s.match(new RegExp(matches)));
};

const composer = [
	load,
	filterPrivate,
	filterDeprecatedCommands,
	removeExtension,
	filterUnique,
	filterParametersMatch,
];

/** @type {string[]} */
const _scripts = composer.reduce((scripts, fn) => {
	return fn(scripts);
}, null);

module.exports = _scripts;
