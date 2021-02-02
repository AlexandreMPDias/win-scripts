Object.defineProperty(Array.prototype, 'transpose', {
	value: function () {
		if (this.length === 0) {
			return this;
		}
		if (this[0].length === 0) {
			return this;
		}
		return this[0].map((_, colIndex) => this.map(row => row[colIndex])).map(x => x.filter(y => y !== undefined));
	}
});
