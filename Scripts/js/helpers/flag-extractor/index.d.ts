type Mutator<T> = (value: string) => T;

interface Args<T> {
  patterns: RegExp[];
  defaultValue: T;
  mutator?: Mutator;
  source?: string;
}

type Extractor<T> = (args: Args<T>) => T;

export const extractFlag: {
  any: <T>(args: Args<T>) => T;
  number: Extractor<number>;
  string: Extractor<string>;
  boolean: Extractor<boolean>;
};
