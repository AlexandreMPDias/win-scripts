const private = require("../config/private.json");
const ArgParser = require("./helpers/parseArguments");
const crypto = require('./helpers/crypto');

const scriptFlags = [
	{
		flag: "c",
		name: "clipboard",
		description: "Copy the output value to clipboard and don't show it on the console",
		default: false,
		type: 'undefined',
	},
];

const parser = ArgParser.load(scriptFlags);

if(parser.count.errors > 0) {
	console.log(Object.values(parser.errors));
	return;
}

let notFound = true;
let valueFound;
private.some((entry) => {
	if(entry.key === parser.valueAt(0, 'rag')) {
		notFound = false;
		valueFound = crypto.decode(entry.value);
		return true;
	}
})
const key = parser.valueAt(0);
if(!key && notFound) {
	if(parser.valueAt(0) === undefined) {
		console.log(`Key not set`);
		console.log(`Valid keys are: [ ${private.map(entry => entry.key).join(', ')} ]`);
	}
	else if(notFound) {
		console.log(`Key [ ${rag} ] not found`);
		console.log(`Valid keys are: [ ${private.map(entry => entry.key).join(', ')} ]`);
	}
} else {
	if(parser.flags['c']) {
		require('child_process').spawn('clip').stdin.end(valueFound);
	} else {
		console.log(valueFound);
	}
}