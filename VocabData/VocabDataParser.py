import os
import json

filename = "VocabData.txt"
output = "VocabData.json"
source = open(filename)

words = []

for line in source:
	w = line.split('/')
	word = {}	
	word["word"] = w[0].strip()
	word["type"] = w[1].strip()
	word["definition"] = w[2].strip()
	words.append(word)

with open(output, 'w') as outfile:
	json.dump(words, outfile)

print words
