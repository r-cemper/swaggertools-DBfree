# Free database space by SwaggerTools  
It's a follow-up to my previous package  [DBdashboard](https://github.com/r-cemper/DBdashboard)    
My special big THANKS go to __Ashok Kumar T__ for providing me with the graphic presentation.   
The graphics of his package [GBLSizeMonitor](https://openexchange.intersystems.com/package/GBLSizeMonitor) were exactly what I was looking for.   

### The idea   
Visualization is one of the key factors for fast recognition of numeric facts.   
I collect the actual DB parameters and show them numerically and visually.    
_Short summary:_    
As in the previous package, all is running from a CSP page.   
And it is all written in pure InterSystems ObjectScript, JavaScript, HTML       
<img src="https://github.com/r-cemper/swaggertools-DBfree/blob/master/final.jpg" width=600>  
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Installation
Clone/git pull the repo into any local directory
```
git clone https://github.com/r-cemper/swaggertools-DBfree.git
```
To build and start the container run:
```
docker compose up -d && docker compose logs -f
```
To open IRIS Terminal do:
```
docker-compose exec iris iris session iris
USER>
```
To access IRIS System Management Portal  

http://localhost:42773/csp/sys/UtilHome.csp  

### How to use it
In your browser simply call   

http://localhost:42773/csp/user/ZX.dbSizeViewer.cls   

As in the previois packages it is now possible to take also a snapshot from    
a remote system. The only requirement is to append an URL parameter formatted:   
#### ?SERVER=IP-Address[:SuperServerPort[:Username[:Password]]]
Example for defaults: _port=1972 user=\_SYSTEM pw=SYS_
Missing URL paramter uses the local system.    
Example:
```
http://localhost:42773/csp/user/ZX..dbSizeViewer?SERVER=192.168.0.11:11972:SuperUser:SYS
```
[Article](https://community.intersystems.com/post/dashboard-database-free-space)    

[Ideas Portal](https://ideas.intersystems.com/ideas/DPI-I-799)   
