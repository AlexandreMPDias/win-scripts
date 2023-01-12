import re

output = open('../__multipledir.bat', 'w')

def loadMaps(file):
	fileContent = file.read()
	maps = fileContent.split("\n")

	def cleanMapRow(row):
		row = re.sub(r"#.+","",row)
		return row

	return [cleanMapRow(row) for row in maps]

try:
	file = open('./paths','r')
	maps = loadMaps(file)


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
		if (map is None) or (len(map) <= 1) :
			continue
		try:
			key, path = map.split('::')
			keys = (keys) + (f"[ {key} ]",)
			mapping += createLine(key,path)
		except Exception as e:
			print('Malformed path [' + map + ']')
			raise e

	mapping += footer(keys)

	output.write(mapping)

	file.close()
	output.close()
except Exception as e:
	raise e
	print('[ paths ] file not found.\nMake sure there\'s a [ paths ] file inside Scripts/config')
	output.write('@echo off\necho [ paths ] file not found.\necho Make sure there\'s a [ path ] file inside Scripts/config')