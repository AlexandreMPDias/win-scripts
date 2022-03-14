export interface NVMAliasConfig {
	readonly aliases: Readonly<Record<string, string>>;
	readonly default: string;
}

export interface NVMLocation {
	readonly clean: string;
	readonly pretty: string;
	readonly path: string;
	readonly exec: {
		readonly nvm: string;
		readonly realNvm: string;
		readonly nvmScriptWrapper: string;
	};
}

export interface NVMAliasScriptBuilderModel {
	config: NVMAliasConfig;
	location: NVMLocation;
}
