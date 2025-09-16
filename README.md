# Snapshot of free disk space
It's an example for the External Languages Contest 2025   
### The idea
An independent external Python module connects to IRIS using  
IRIS Native API for Python collects disk data and transforms  
the findings in a barchart and a table with numeric details.  
Data collection happens inside IRIS, graphics are prepared in Python   
The final results are embedded in a CSP page.  
<img src="https://github.com/r-cemper/DKfree/blob/master/dkfree1.jpg">    

### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Installation
Clone/git pull the repo into any local directory
```
git clone https://github.com/r-cemper/DBfree.git
```
To build and start the container run:
```
docker compose up -d && docker compose logs -f
```
To access docker console terminal
```
docker-compose exec iris bash
```
To open IRIS Terminal do:
```
docker-compose exec iris iris session iris
USER>
```
To access IRIS System Management Portal
```
http://localhost:42773/csp/sys/UtilHome.csp
```
To consume the Graphics
```
http://localhost:42773/csp/user/ZX.nacl.cls
```
### How to use it
The Demo starts from Docker shell  
You enter server, port, namespace, user, password  
Then the Python module connects, collects data and prepares the image.
##### slow start   
```
C:\GitHub\_my\_dkfree>docker-compose exec iris bash
irisowner@6597ac7a2c23:/opt/irisapp$ python3 /ext/dkfree.py
```
##### quick start  
```
C:\GitHub\_my\_dkfree>docker-compose exec iris python3 /ext/dkfree.py   
```
<img src="https://github.com/r-cemper/DKfree/blob/master/txt.jpg"></img> 
##### more
[Video](https://youtu.be/IZtPmMc-yiI)  

[Article 1](https://community.intersystems.com/post/snapshot-free-disk-space)

[Article 2](https://community.intersystems.com/post/snapshot-db-free-strategies)

   
