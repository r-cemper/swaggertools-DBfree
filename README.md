# Dashboard of free disk space   
It's a follow on to my previous package  [DBfree](https://github.com/r-cemper/DBfree)   
### The idea   
As DeepSee in IRIS can display tables and graphics in a dashboard, I tried to fill   
in the actual DB parameters and to visualize them. 
Short summary:   
It is possible and an interesting exercise to misuse DepSee as a graphic viewer.  
As in the previous package, all is running from a CSP page.       
<img src="https://github.com/r-cemper/DBdashboard/blob/master/final.jpg" width=600>      
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Installation
Clone/git pull the repo into any local directory
```
git clone https://github.com/r-cemper/DBdashboard.git
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
```
http://localhost:42773/csp/sys/UtilHome.csp
```
### How to use it
In your browser simply call   
```
http://localhost:42773/csp/user/ZX.dbdash.cls
```
[Ideas Portal](https://ideas.intersystems.com/ideas/DPI-I-799)   
