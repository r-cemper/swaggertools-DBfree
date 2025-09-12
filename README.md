# Snapshot of free disk space
It's an example for the External Languages Contest 2025   
### The idea
An independent external Python module connects to IRIS using  
IRIS Native API for Python collects disk data and transforms  
the result in a barchart and a table with numeric details.  
Data collection happens inside IRIS, graphics are prepared in Python   
the final result is embedded in a CSP page.  


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
### How to use it
This presents  
