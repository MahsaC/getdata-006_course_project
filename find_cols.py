f = open('features.txt','r')
lines = f.readlines()
f.close()
needed = []
names = []
for l in lines:
    if '-mean()' in l or '-std()' in l:
        needed.append("V"+l[:l.index(' ')])
        n = l[l.index(' ')+1:-1]
        n = n.replace("-",'_')
        n = n.replace("()",'')
        names.append(n)    
print needed
print names


