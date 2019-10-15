const [scriptName, nodePath, batchPath, source, ...parameters] = process.argv;

const params = parameters || [];

const flagConfigExample = [
	{
		// Flag key
		flag: "b",
		
		// Default value for the flag
		dft: 0, // default = undefined

		// Flag's type's value
		type: "number|string", // default = typeof dft, flags without pair = "undefined"

		// is the flag necessary
		required: true // default = false
	}
]

function createMessage(type, key, str2, str3) {
	if(type === 'required') {
		return `A flag [ ${key} ] é obrigatória e seu valor não foi setado.`
	}
	if(type === 'last') {
		return `A flag [ ${key} ] é obrigatória e foi o último parametro recebido. seu valor não foi setado.`
	}
	if(type === 'invalidType') {
		return `{ ${str2} } não é um valor válido para [ ${key} ], Essa flag espera um valor do tipo ${str3}. (1-based index)`
	}
}

module.exports = {
	load: (flagConfig = []) => {
		const flags = {};
		const errors = {};
		const warnings = {};
		const values = [];

		function isFlag(flag) {
			const cleanFlag = flag.replace(/^-/,'');
			return flagConfig.some(f => f.flag === cleanFlag);
		}
		function isLastIndex(i) {
			return i + 1 >= params.length;
		}

		function getFlagFromParam(at) {
			const flagKey = params[at].replace(/^-/,'');
			return flagConfig.find(f => f.flag === flagKey)
		}

		for(let i = 0; i < params.length; i++) {
			const flagPair = getFlagFromParam(i);
			if(flagPair) {
				const { flag, type, dft , required } = flagPair
				if(type === "undefined") {
					flags[flag] = true;
				}
				else {
					if(isLastIndex(i)) {
						errors[flag] = createMessage('last', flag)
					} else if(isFlag(params[i+1])) {
						errors[flag] = createMessage('required', flag)
					} else {
						flags[flag] = params[i+1];
						i++;
					}
				}
			} else {
				values.push(params[i]);
			}
		}

		flagConfig.forEach(fc => {
			const valueSet = flags[fc.flag];
			// Validate Type
			const types = fc.type.split("|");
			if(types.includes("string")) {

			} else if(types.includes("number")) {
				if(Number.isNaN(Number(valueSet))) {
					errors[fc.flag] = createMessage('invalidType', valueSet, fc.type)
				}
			}

			// Validate Required and set default
			if(valueSet === undefined) {
				// Validate Required
				if(fc.required) {
					errors[fc.flag] = createMessage('required', fc.flag)

				// Set default
				} else if(fc.dft !== undefined){
					flags[fc.flag] = fc.dft;
				}
			}
		})
		
		return {
			paramValues: values,
			flags,
			errors,
			valueAt: (at, defaultValue) => values[at] || defaultValue,
			args: {
				scriptName,
				nodePath,
				batchPath,
				source,
				params
			}
		}
	},
	flagParser: (flag, dft,  type,  required) => {
		const ifSet = (a,b) => a ? a : b
		return {
			flag,
			dft,
			type: ifSet(type, typeof dft),
			required: ifSet(required, false)
		}
	}
}