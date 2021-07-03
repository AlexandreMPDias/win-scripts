const { getArgs } = require('../../helpers');
const path = require('path');
const Runner = require('./runner');

const runner = new Runner();

const [url, paramName] = getArgs(__dirname);

const download = (p) => path.resolve(path.join(process.env.APPDATA, '..', '..', 'Downloads', p));

const quote = str => str

const resolveName = () => {
	let name = paramName
	if (!name) {
		const d = new Date();
		const timestamp = [d.getHours(), d.getMinutes(), d.getSeconds()].map(String).map(x => x.padStart(2, '0')).join('_');
		name = `video__${timestamp}`;
	}

	return download(name + '.mp4')
}

runner.run("youtube-dl", ["--all-subs", "-f", "mp4", "-o", quote(resolveName()), quote(url)]).catch(console.error);