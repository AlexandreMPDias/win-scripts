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

function getArgs(dirname) {
	const argLister = new ArgLister(dirname);
	return argLister.getArgs();
}

module.exports = {
	getArgs,
	argsHaveAnyFlag: (args, ...flags) => {
		flags = flags.map(String);
		const allflags = new Set([
			...flags.map(f => `--${f}`),
			...flags.map(f => `-${f.charAt(0)}`),
		]);
		return args.some(arg => allflags.has(arg));
	},
};
