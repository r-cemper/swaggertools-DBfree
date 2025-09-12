# Snapshot of free disk space
It's an example for the External Languages Contest 2025   
### The idea
An independent external Python module connects to IRIS using  
IRIS Native API for Python collects disk data and transforms  
the findings in a barchart and a table with numeric details.  
Data collection happens inside IRIS, graphics are prepared in Python   
The final results are embedded in a CSP page.  
<img src=https://github.com/r-cemper/DKfree/blob/master/tab.jpg>    
#### Collected Data Values  
````
  DataBaseName  MBtotal  MBfree  %free    
       IRISSYS       70    3.20      5   
      HSCUSTOM       21    8.50     40  
        ENSLIB      217   16.00      7   
         HSLIB     1362    0.77      0   
         HSSYS       21    8.40     40   
HSSYSLOCALTEMP        1    0.33     33   
     IRISAUDIT       11    6.30     57  
       IRISLIB      368    0.59      0  
 IRISLOCALDATA       11    9.40     85   
   IRISMETRICS        1    0.29     29  
      IRISTEMP       11    9.00     82   
          USER       11    9.90     90   
           IPM       14    2.50     18   
````          
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Installation
Clone/git pull the repo into any local directory
```
git clone https://github.com/r-cemper/DKfree.git
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
```
C:\GitHub\_my\_dkfree>docker-compose exec iris bash
irisowner@6597ac7a2c23:/opt/irisapp$ python3 /ext/dkfree.py
>>> serverIP [127.0.0.1]:
>>> serverPORT [1972]:
>>> namespace [USER]:
>>> username [_SYSTEM]:
>>> password [SYS]:
ECHO := Connection Up
Connected to Instance IRIS on Server 6597AC7A2C23

Collected Data Values  
DB Free on Server 6597AC7A2C23/IRIS
  DataBaseName  MBtotal  MBfree  %free
       IRISSYS       70    3.20      5
      HSCUSTOM       21    8.50     40
        ENSLIB      217   16.00      7
         HSLIB     1362    0.77      0
         HSSYS       21    8.40     40
HSSYSLOCALTEMP        1    0.33     33
     IRISAUDIT       11    6.30     57
       IRISLIB      368    0.59      0
 IRISLOCALDATA       11    9.40     85
   IRISMETRICS        1    0.29     29
      IRISTEMP       11    9.10     83
          USER       11    9.90     90
           IPM       14    2.50     18
Image stored here: /ext/tab.jpg
Table stored here: /ext/tab.txt
view results here: http://localhost:42773/csp/user/ZX.nacl.cls

Thank you for trying the demo

irisowner@6597ac7a2c23:/opt/irisapp$
```   


   
