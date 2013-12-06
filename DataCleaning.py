import sys, csv, string

def write(corpus_file, output=None):
	l = csv.reader(corpus_file,delimiter=',')
	next(l, None)
	for line in l:
		print line[1].translate(None, string.punctuation).translate(None, string.digits)
	# 	try:
	# 		output.write(line[3]+"\n")
	# 	except IndexError:
	# 		print "No tags"
	# 		pass

if __name__ == '__main__':
	input_file = file("sample-train.csv","r")
	write(input_file)
	# if len(sys.argv)!=2:
	# 	sys.exit(2)
	# try:
	# 	input_file = file(sys.argv[1],"r")
	# except IOError:
	# 	sys.stderr.write("ERROR: Cannot read input file %s." % arg)
	# 	sys.exit(1)

	# write(input_file, sys.stdout)
