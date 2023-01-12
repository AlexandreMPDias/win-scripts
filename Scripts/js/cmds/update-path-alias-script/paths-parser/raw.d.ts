export type Path = Path.Obj | Path.Arr;

export interface Group {
	readonly name: string;
	readonly paths: ReadonlyArray<Path>;
}

export namespace Path {
	export type Alias = string;
	export type PathValue = string;

	export type Arr = readonly [Alias | readonly Alias[], PathValue];
	export interface Obj {
		readonly aliases: Alias[];
		readonly path: string;
		readonly paths?: ReadonlyArray<Path>;
	}
}

export interface File {
	readonly paths?: ReadonlyArray<Path>;
	readonly groups?: ReadonlyArray<Group>;
}
