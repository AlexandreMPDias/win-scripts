const fs = require('fs');
const path = require('path');

const privateJSON = path.join(__dirname, '..', 'config','private.json');
const appendToPrivate = (c) => {
	return fs.writeFileSync(privateJSON, c , {encoding: 'utf-8'});
}

const ArgParser = require("./helpers/parseArguments");
const crypto = require('./helpers/crypto');

const parser = ArgParser.load();

if(parser.count.errors > 0) {
	console.log(Object.values(parser.errors));
	return;
}

console.log(`CreatingEntry:`)
console.log({key: parser.paramValues[0],name: parser.paramValues[1], value: parser.paramValues[2]})

const entry = {
	key: parser.paramValues[0],name: parser.paramValues[1], value: crypto.encode(parser.paramValues[2])
}

const content = require(privateJSON);

content.push(entry);

appendToPrivate("[\n" + content.map(c => {
	return `\t${JSON.stringify(c)}`
}).join(',\n') + "\n]")