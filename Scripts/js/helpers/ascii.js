function stripASCIIStyle(message) {
	return message.replace(
		/[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g,
		''
	);
}
module.exports = { stripASCIIStyle };
