import os
import json

filename = "VocabData.txt"
groupsInput = "WordGroupData.txt"
output = "VocabData.json"

source = open(filename)

words = {}

for line in source:
	w = line.split('/')
	key = w[0].strip()
	if words.has_key(key):
		word = words[key]
	else:
		word = {}
		word["definitions"] = []
	aType = w[1].strip()
	aDefinition = w[2].strip()
	definition = {}
	definition["type"] = aType
	definition["definition"] = aDefinition
	word["definitions"].append(definition)
	words[key] = word

source = open(groupsInput)

for line in source:
	group = line.split(":")
	print group
	groupName = group[0].strip()
	terms = group[1].split(",")
	for t in terms:
		term = t.strip()
		if words.has_key(term):
			word = words[term]
		else:
			word = {}
		
		if word.has_key("groups"):
			groups = word["groups"]
		else:
			groups = []
			word["groups"] = groups
		groups.append(groupName)
		words[term] = word

with open(output, 'w') as outfile:
	json.dump(words, outfile)

print words
