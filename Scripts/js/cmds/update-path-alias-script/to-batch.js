const { chalk, configPaths, polyfills, fromConfig } = require('../../helpers');
const fs = require('fs');

class BatchHelper {
	arg = position => `%${position}`;
	escape = char => `^${char}`;
	brackets = message => this.escape('[') + message + this.escape(']');
	tab = (size = 1) => '\t'.repeat(size);

	userInput = {
		alias: () => this.arg(1),
		command: () => this.arg(2),
	};
}

class Batch {
	constructor(path) {
		this.__path = path;
		this.__content = [];
		this.__aliases = [];
		this.utils = new BatchHelper();
	}

	add = line => {
		this.__content.push(line);
		return this;
	};

	br = (after = '') => {
		this.__content.add('' + after);
		return this;
	};
	tab = (after = '') => {
		this.__content.add('\t' + after);
		return this;
	};

	ifFirstArgIsAlias(alias, path) {
		this.__aliases.push(alias);
		const userInputAlias = this.utils.userInput.alias();
		const userCommand = this.utils.userInput.command();
		return this.add(`
		if [${userInputAlias}] == [${alias}] (
			${userCommand} ${path}
			goto:eof
		`);
		// return this.add(`if [%1] == [${alias}] (\n\t%2 ${path}\n\tgoto:eof\n)\n`)
	}

	header() {
		return this.add('@echo off').ifFirstArgIsAlias('.', '.').ifFirstArgIsAlias('..', '..');
	}

	show = message => {
		return this.add(`echo ${message}`);
	};

	footer() {
		this.add(
			`echo Invalid key ${this.utils.brackets(this.utils.arg(1))} received. Valid keys are:`
		);
		this.__aliases.forEach(alias => {
			this.add(this.utils.tab(1) + '- ' + alias);
		});
		return this;
		// const allKeys = this.__aliases.join(', ');
		// return this.show(`Invalid key ${this.utils.brackets(this.utils.arg(1))} received`)
		// return this.add(`echo Invalid key received. Valid keys are:\necho {allKey}\n`)
	}
}

module.exports = { Batch };
