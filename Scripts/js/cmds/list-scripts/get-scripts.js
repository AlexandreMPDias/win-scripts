const fs = require('fs');
const path = require('path');
const { deprecated } = require('./assets')
const bin = path.resolve(path.join(path.dirname(process.argv[1]), '..', '..', '..', 'bin'))

const load = () => {
	return fs.readdirSync(bin, { encoding: 'utf-8' });
}

const filterPrivate = (scripts) => {
	return scripts.filter(s => !s.match(/^_/));
}

const filterDeprecatedCommands = (scripts) => {
	return scripts.filter(s => !deprecated.some(d => s.match(d)))
}

const removeExtension = (scripts) => {
	return scripts.map(s => path.parse(s).name);
}

const filterUnique = (scripts) => {
	const set = new Set(scripts);
	return Array.from(set);
}

const composer = [
	load,
	filterPrivate,
	filterDeprecatedCommands,
	removeExtension,
	filterUnique
]

/** @type {string[]} */
const _scripts = composer.reduce((scripts, fn) => {
	return fn(scripts);
}, null)

module.exports = _scripts;