
(function () {
	var childProcess = require("child_process");
	var oldSpawn = childProcess.spawn;
	function mySpawn() {
		var result = oldSpawn.apply(this, arguments);
		result.on("error", (err) => {
			console.log('spawn called');
			console.log(arguments);
		})
		return result;
	}
	childProcess.spawn = mySpawn;
})();

const { spawn } = require('child_process');


class Runner {
	run = (cmd, args) => {

		return new Promise((resolve, reject) => {
			const cp = spawn(cmd, args, { stdio: 'pipe' });

			console.log("starting");

			cp.stdout.setEncoding('utf8')
			cp.stdout.on("data", console.log)

			cp.stderr.setEncoding('utf8')
			cp.stderr.on("data", console.log)

			cp.on('error', reject);
			cp.on('exit', (code) => {
				console.log(`Child exited with code ${code}`);
			});
		});
	}
}

module.exports = Runner