const private = require("../config/private.json");
const ArgParser = require("./helpers/parseArguments");

const scriptFlags = [
	ArgParser.flagParser('c', false, "undefined"),
];

const parser = ArgParser.load(scriptFlags);

let notFound = true;
let valueFound;
private.some((entry) => {
	if(entry.key === parser.valueAt(0, 'rag')) {
		notFound = false;
		valueFound = (entry.value);
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
		const util = require('util');
		console.log(valueFound);
		require('child_process').spawn('clip').stdin.end(valueFound);
		// require('child_process').spawn('clip').stdin.end(util.inspect(valueFound));
	} else {
		console.log(valueFound);
	}
}