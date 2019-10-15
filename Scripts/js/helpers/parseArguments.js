const [scriptName, nodePath, batchPath, source, ...parameters] = process.argv;

const params = parameters || [];

const flagConfigExample = [
	{
		// Flag key
		flag: "help",
		
		// Default value for the flag
		default: 0, // default = undefined

		// Flag's type's value
		type: "number|string", // default = typeof default, flags without pair = "undefined"

		// is the flag necessary
		required: false, // default = false

		name: "Command Line Help",

		description: "Show the Command Line Flag Help",
	}
]

function createMessage(type, key, str2, str3) {
	if(type === 'required') {
		return `A flag [ ${key} ] é obrigatória. Seu valor não foi setado.`
	}
	if(type === 'last') {
		return `A flag [ ${key} ] é obrigatória e foi o último parametro recebido. Seu valor não foi setado.`
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
		let numErrors = 0;
		let numWarnings = 0;

		function cleanFlag(f) { return f.replace(/^-/,'') };

		function isFlag(flag) {
			const clean = cleanFlag(flag);
			return flagConfig.some(f => f.flag === clean);
		}
		function isLastIndex(i) {
			return i + 1 >= params.length;
		}

		function set(key, flagKey, value, keyName = "error") {
			if(keyName === 'error') numErrors++;
			else numWarnings++;
			key[flagKey] = value;
		}

		function getFlagFromParam(at) {
			const flagKey = cleanFlag(params[at]);
			return flagConfig.find(f => f.flag === flagKey)
		}

		for(let i = 0; i < params.length; i++) {
			if(cleanFlag(params[i]) === 'help') {
				console.log(flagConfig);
			}
			const flagPair = getFlagFromParam(i);
			if(flagPair) {
				const { flag, type } = flagPair
				if(type === "optional") {
					if(!isLastIndex(i) && !isFlag(params[i+1])) {
						flags[flag] = params[i+1];
						i++;
					} else {
						flags[flag] = undefined;
					}
				}
				else if(type === "undefined") {
					flags[flag] = true;
				}
				else {
					if(isLastIndex(i)) {
						set(errors, flag, createMessage('last', flag));
					} else if(isFlag(params[i+1])) {
						set(errors, flag, createMessage('required', flag));
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
			if(typeof fc.type === 'string') {

				// Validating String Types
				const types = fc.type.split("|");
				if(types.includes("string")) {
					// nothing

				} else if(types.includes("number")) {

					if(Number.isNaN(Number(valueSet))) {
						set(errors, fc.flag, createMessage('invalidType', fc.flag, valueSet, fc.type));
					}
				}

				// Validate Enum Types
			} else if(Array.isArray(fc.type)) {

				if(!fc.type.includes(valueSet) && fc.required) {

					set(errors, fc.flag, createMessage('invalidType', fc.flag, valueSet,`[ ${fc.type.join(',')} ]`));
				}
			}

			// Validate Required and set default
			if(valueSet === undefined) {
				// Validate Required
				if(fc.required) {
					set(errors, fc.flag,  createMessage('required', fc.flag));


				// Set default
				} else if(fc.default !== undefined){
					flags[fc.flag] = fc.default;
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
			},
			count: {
				errors: numErrors,
				warnings: numWarnings
			}
		}
	}
}