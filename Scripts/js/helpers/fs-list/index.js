const fs = require('fs');
const path = require('path')

class FSRecursive {
	constructor(recursive) {
		this.recursive = recursive;
		this.items = [];
	}
}

class FSListClass {

	dir = async (location) => {

	}

	files = (location, recursive = false) => {
		const rec = recursive instanceof FSRecursive ? recursive : new FSRecursive(recursive);
		const { files, dirs } = this.read(location)
		rec.items = files
		if (rec.recursive) {
			dirs.forEach(dir => this.files(path.join(location, dir), rec))
		}
		return rec.items;
	}

	read = (location) => {
		const dirs = [];
		const files = [];
		fs.readdirSync(location).forEach(filePath => {
			(this.is.File(filePath) ? files : dirs).push(filePath)
		})

		return { dirs, files }
	}

	is = {
		File: (fileOrDir) => fs.statSync(fileOrDir).isFile(),
		Dir: (fileOrDir) => fs.statSync(fileOrDir).isDirectory(),
		Blocked: (fileOrDir) => fs.statSync(fileOrDir).isBlockDevice(),
	}

}

module.exports = { FSList: new FSListClass() }