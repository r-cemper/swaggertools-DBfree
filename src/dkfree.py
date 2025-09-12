import irisnative as iris

# show local variables
def zw():
    for name, value in globals().copy().items():
        print(name, value)

        
def cmd(what,default):
    prompt=">>> "+what+" ["+default+"]: "
    ans=input(prompt)
    if (ans=="") :
        ans=default
    return ans
    
# defaults():
ip   = "127.0.0.1"
port = "1972"
nspc = "USER"
user = "_SYSTEM"
pwd  = "SYS"

# change connection
ip   = cmd("serverIP",ip)
port = cmd("serverPORT",port)
nspc = cmd("namespace",nspc)
user = cmd("username",user)
pwd  = cmd("password",pwd)
# get connected
conn = iris.createConnection(ip,int(port),nspc,user,pwd)
db = iris.createIris(conn)
ans=db.classMethodValue("ZX.nacl","echo","Connection Up")
print(ans)
inst=db.classMethodValue("%SYS.System","GetInstanceName")
node=db.classMethodValue("%SYS.System","GetNodeName")
print("Connected to Instance "+inst+" on Server "+node+"\n")

free=db.classMethodValue("ZX.nacl","sql")
dbname=db.get("%zrcc",1).split()
mbsize=db.get("%zrcc",2).split()
mbs=[int(x) for x in mbsize]
mbavail=db.get("%zrcc",3).split()
mba=[float(x) for x in mbavail]
przavail=db.get("%zrcc",4).split()
prz=[int(x) for x in przval]
tab=pd.DataFrame({"DBname": dbname, "MBsize":mbs,"MBfree":mba,"%free":prz})
print(tab.to_string(index=False))
zw()



# demo selection

print("\nThank you for trying the demo\n")
db.close()
conn.close()


