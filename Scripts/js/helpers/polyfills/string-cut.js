String.prototype.tail = function (maxLength) {
	return this.slice(Math.max(this.length - maxLength, 0), this.length)
}

String.prototype.head = function (maxLength) {
	return this.slice(0, maxLength)
}