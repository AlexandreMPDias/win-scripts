output = open('../__multipledir.bat', 'w')
try:
	file = open('./paths','r')
	fileContent = file.read()

	maps = fileContent.split("\n")


	def createLine(key, path):
		return f"if [%1] == [{key}] (\n\t%2 {path}\n\tgoto:eof\n)\n"

	def header():
		return f"@echo off\n{createLine('.','.')}{createLine('..','..')}"

	def footer(keys):
		allKey = ', '.join(keys)
		return f"echo Invalid key received. Valid keys are:\necho {allKey}\n"

	mapping = ''
	mapping += header()
	keys = ('[ . ]','[ .. ]')
	for map in maps:
		if len(map) < 1 :
			continue
		try:
			key, path = map.split('::')
			keys = (keys) + (f"[ {key} ]",)
			mapping += createLine(key,path)
		except:
			print('Malformed path [' + map + ']')

	mapping += footer(keys)

	output.write(mapping)

	file.close()
	output.close()
except Exception as e:
	print('[ paths ] file not found.\nMake sure there\'s a [ paths ] file inside Scripts/config')
	output.write('@echo off\necho [ paths ] file not found.\necho Make sure there\'s a [ path ] file inside Scripts/config')