import sys
import operator
import codecs
from re import *

f=codecs.open('result','r','UTF-8');
print f.readline().strip()
print f.readline().strip()
print f.readline().strip()
count=0;
for line in f:
	dic=dict()
	print str(count+1)
	line=line.lower().strip();
	line=sub(r'\{','',line);
	line=sub(r'\}','',line);
	line_split=line.split(',');
	for s in line_split:
		s_split=s.split(':');
		if len(s_split)<=1:
			continue;
		if s_split[0] not in dic:
			dic[s_split[0]]=float(s_split[1])
	sorted_x = sorted(dic.iteritems(), key=operator.itemgetter(1)) 
	i=10
	result=[]
	for w in sorted_x:
		result.append(w[0])
		i=i-1
		if i<0:
			break
	print " ".join(result)
	count+=1;
f.close();
