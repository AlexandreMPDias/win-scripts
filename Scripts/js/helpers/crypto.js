const crypto = require('crypto');

const algorithm = 'aes-192-cbc';
const password = 'Password used to generate key';
// Use the async `crypto.scrypt()` instead.
const key = crypto.scryptSync(password, 'salt', 24);
// Use `crypto.randomBytes` to generate a random iv instead of the static iv
// shown here.
const iv = Buffer.alloc(16, 0); // Initialization vector.

const cipher = crypto.createCipheriv(algorithm, key, iv);
const decipher = crypto.createDecipheriv(algorithm, key, iv);

module.exports = {
	encode: (text) => cipher.update(text, 'utf8', 'hex') + cipher.final('hex'),
	decode: (encrypted) =>  decipher.update(encrypted, 'hex', 'utf8') + decipher.final('utf8'),
	// decode: (encryptedText) => {
	// 	console.log(encryptedText);
	// 	let decrypted = '';
	// 	decipher.on('readable', () => {
	// 	while (null !== (chunk = decipher.read())) {
	// 		decrypted += chunk.toString('utf8');
	// 	}
	// 	});
	// 	decipher.on('end', () => {
	// 		console.log(decrypted);
	// 	});
	// 	decipher.write(encryptedText, 'hex');
	// 	decipher.end();
	// 	return decrypted;

	// }
}