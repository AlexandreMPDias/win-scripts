export interface Path {
	readonly group: string;
	readonly alias: string;
	readonly path: string;
}

export interface Content {
	readonly paths: ReadonlyArray<Path>;
}
