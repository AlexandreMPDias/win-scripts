const internal = Symbol('internal');

const TAB = '\t';

class NVMScriptBuilderInternal {
	constructor(contents, indentationLevel) {
		this.contents = contents;
		this.indentationLevel = indentationLevel;
	}

	withIndentation = contentOrGetCetContent => {
		this.indentationLevel++;
		const content =
			typeof contentOrGetCetContent === 'function'
				? contentOrGetCetContent()
				: contentOrGetCetContent;
		if (typeof content === 'string') {
			this.write(content);
		}
		this.indentationLevel--;
	};

	writeArray = lines => {
		this.contents.push(
			...lines.map(contentLine => TAB.repeat(this.indentationLevel) + contentLine)
		);
	};

	write = content => {
		if (content === undefined) return;
		if (Array.isArray(content)) {
			return this.writeArray(content);
		}
		if (typeof content === 'object') {
			return this.writeArray(content[internal].contents);
		}
		return this.writeArray(content.split('\n'));
	};

	compose = () => {
		return this.contents.join('\n');
	};
}

class NVMScriptBuilder {
	static compose = builder => {
		return builder[internal].compose();
	};

	constructor(internalBuilder = null) {
		this[internal] = internalBuilder || new NVMScriptBuilderInternal(['@echo off'], 0);
	}

	utils = {
		goEnd: 'goto :eof',
		ifAliasIs: alias => `[%2] == [${alias}]`,
		ifCommandIs: cmd => `[%1] == [${cmd}]`,
	};

	/**
	 * @param {string} condition
	 * @param {boolean} endCondition
	 * @returns {(nested: NVMScriptBuilder): NVMScriptBuilder} getContentOrBuilder
	 */
	if = (condition, endCondition = false) => {
		return contentOrBuilder => {
			this.write(`if ${condition} (`);

			this.writeIndented(contentOrBuilder);
			if (endCondition) this.writeIndented(n => n.end());
			this.write(')');
			return this;
		};
	};

	/**
	 * @param {string} alias
	 * @param {(nested: NVMScriptBuilder) => NVMScriptBuilder} getContentOrBuilder
	 * @returns {NVMScriptBuilder}
	 */
	ifAlias = (alias, getContentOrBuilder) => {
		return this.if(`[%2] == [${alias}]`, true)(getContentOrBuilder);
	};

	/**
	 * @param {string} cmd
	 * @param {(nested: NVMScriptBuilder) => NVMScriptBuilder} getContentOrBuilder
	 * @returns {NVMScriptBuilder}
	 */
	ifCommand = (cmd, getContentOrBuilder) => {
		return this.if(`[%1] == [${cmd}]`)(getContentOrBuilder);
	};

	echo = (content = '') => {
		const lines = (Array.isArray(content) ? content : content.split('\n')).map(contentLine => {
			if (contentLine.trim().length === 0) {
				return '.';
			}
			return ' ' + contentLine;
		});
		this.write(lines.map(contentLine => `echo${contentLine}`));
		return this;
	};

	end = () => {
		return this.write(this.utils.goEnd);
	};

	nvm = cmd => {
		return this.write(`real-nvm ${cmd}`);
	};

	/**
	 * @param {number} level
	 * @param {(nested: NVMScriptBuilder) => NVMScriptBuilder} callback
	 * @returns {string[]}
	 */
	indent = (level, callback) => {
		const otherInternal = new NVMScriptBuilderInternal([], level);
		const nested = new NVMScriptBuilder(otherInternal);
		return callback(nested) || nested;
	};

	/**
	 * @param {(nested: NVMScriptBuilder) => NVMScriptBuilder} callback
	 * @returns {NVMScriptBuilder}
	 */
	writeIndented = callback => {
		const nested = this.indent(1, callback);
		const nestedContent = nested[internal].compose();
		return this.write(nestedContent);
	};

	write = content => {
		this[internal].write(content);
		return this;
	};
}

module.exports = { NVMScriptBuilder };
