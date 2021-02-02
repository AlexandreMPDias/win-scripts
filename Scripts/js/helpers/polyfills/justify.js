String.prototype.justifyLeft = function (length, char = " ") {
	var fill = [];
	while (fill.length + this.length < length) {
		fill[fill.length] = char;
	}
	return fill.join('') + this;
}

String.prototype.justifyRight = function (length, char = " ") {
	var fill = [];
	while (fill.length + this.length < length) {
		fill[fill.length] = char;
	}
	return this + fill.join('');
}

String.prototype.justifyCenter = function (length, char = " ") {
	var i = 0;
	var str = this;
	var toggle = true;
	while (i + this.length < length) {
		i++;
		if (toggle)
			str = str + char;
		else
			str = char + str;
		toggle = !toggle;
	}
	return str;
}