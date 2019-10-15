const fs = require('fs');
const path = require('path');

const [scriptName, nodePath, batchPatch, source, ...args] = process.argv;

const ArgParser = require("./helpers/parseArguments");

const scriptFlags = [
	{
		flag: "f",
		name: "fileName",
		description: "The relative path of the json file in the current dir to be opened",
		default: "package.json",
		type: 'string',
	},
	{
		flag: "p",
		name: "prop",
		description: "The json's file property to be read. [Nested props with (.) are accepted]",
		default: "scripts",
		type: 'optional',
	},
	{
		flag: "m",
		name: "mode",
		description: "The output mode to display the file's property",
		default: "keysOnly",
		type: ['full', 'keysOnly'],
	}
];

const parser = ArgParser.load(scriptFlags);

if(parser.count.errors > 0) {
	console.log(Object.values(parser.errors));
	return;
}

const config = Object.entries(parser.flags).reduce((comb, curr) => {
	comb[scriptFlags.find(f => f.flag === curr[0]).name] = curr[1];
	return comb; 
}, {});


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


const filePath = path.join(parser.args.batchPath, config.fileName);


const json = resolveJSONProp(require(filePath), config.prop);



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


