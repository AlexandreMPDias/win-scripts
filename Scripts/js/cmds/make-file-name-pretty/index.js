const { FSList, chalk } = require('../../helpers');
const path = require('path');
const _ = require('./helpers');
const filter = require('./filters');
const transform = require('./transformations')

console.log();

const allFiles = FSList.files(process.cwd()).map(file => new _.File(path.join(process.cwd(), file)))

const { accepted, rejected } = filter(allFiles);

_.showRejected(rejected);

transform(accepted);

_.rename(accepted);