const fs = require('fs');
const path = require('path');

const [nodePath, batchPatch, source, ...args] = process.argv;

const validModes = ['full', 'keysOnly'];

const config = {
	fileName: 'package.json',
	prop: 'scripts',
	mode: 'keysOnly'
}

for (let i = 0; i < args.length; i++) {
	if (args[i] === '-np') {
		config.prop = '';
	}
	else if (args[i] === '-f') {
		config.fileName = args[i + 1];
		i++;
	}
	else if (args[i] === '-p') {
		config.prop = args[i + 1];
		i++;
	}
	else if (args[i] === '-m') {
		config.mode = args[i + 1];
		i++;
	}
}

function resolveJSONProp(json, prop) {
	let resolved = json;
	if (prop.includes('.')) {
		const subProp = prop.split('.');
		subProp.forEach(p => {
			resolved = resolved[p];
		})
	} else if (prop !== "") {
		resolved = resolved[prop];
	}
	return resolved;
}

const json = resolveJSONProp(require(path.join(source, config.fileName)), config.prop);



if (config.mode === 'full') {
	if (typeof json === 'string') {
		console.log(json);
	} else {
		Object.entries(json).map(([key, value], index) => {
			if (index !== 0) {
				console.log(new Array(10).fill('=').join('-') + '\n');

			}
			console.log([key]);
			console.log(value);
		})
	}
} else if (config.mode === 'keysOnly') {
	console.log(Object.keys(json));
} else {
	console.log(`${config.mode} is not a valid mode.`);;
	console.log(`Valid modes are: ${validModes.join(',')}`);
}


