class ArgLister {
	constructor(dirname = '') {
		this.scriptName = String(dirname.split(/\\|\//g).pop() || '');
		this.nonBinaryPathFound = false;
	}

	getArgs() {
		// let output = [];
		const args = process.argv.filter(arg => {
			const shouldKeep = this.__shouldKeep(arg);
			// output.push({arg, shouldKeep});
			return shouldKeep;
		});
		// throw output;
		return args;
	}

	__parseDirname(dirname) {
		return dirname.split(/\\|\//g).pop() || '';
	}

	__shouldKeep(arg) {
		if (arg.startsWith('C:')) {
			if (!this.nonBinaryPathFound) {
				return false;
			}
			return true;
		} else {
			this.nonBinaryPathFound = false;
		}
		if (arg === this.scriptName) {
			return false;
		}
		return true;
	}
}

function toDefaultAlias(flag) {
	if (flag.startsWith('-')) return flag.replace(/^-(-.).+/, '$1');
	return flag[0];
}

function getArgs(dirname) {
	const argLister = new ArgLister(dirname);
	return argLister.getArgs();
}

function getFlagKeys(argv) {
	const flags = argv.filter(arg => arg.startsWith('--') || arg.startsWith('-'));
	const withoutHiphen = flags.map(f => f.replace(/^--?/, ''));
	return new Set(withoutHiphen);
}

const argsHaveFlag = (argv, flagName, flagAlias = '') => {
	const alias = flagAlias ?? toDefaultAlias(flagName);
	const flagKeys = getFlagKeys(argv);
	if (flagKeys.has(flagName)) return true;
	if (alias !== null && flagKeys.has(alias)) return true;
	return false;
};

module.exports = {
	getArgs,
	getFlagKeys,
	/** @type {(args: any[], ...flags: string[]) => boolean} */
	argsHaveAnyFlag: (argv, ...flags) => {
		const argvFlags = getFlagKeys(argv);
		return flags.some(flag => argvFlags.has(flag));
	},
	/** @type {(args: any[], ...flags: Array<string | {key: string, alias: string}>) => boolean} */
	loadBooleanFlags: (argv, flags) => {
		const output = {};
		const flagKeys = getFlagKeys(argv);
		flags.forEach(flag => {
			const flagConfig = typeof flag === 'string' ? { key: flag, alias: null } : flag;
			const { key, alias } = flagConfig;
			if (flagKeys.has(key)) {
				output[key] = true;
			} else if (alias !== null && flagKeys.has(alias)) {
				output[key] = true;
			}
		});
		return output;
	},
};
