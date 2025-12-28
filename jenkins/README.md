# SLink on Docker with Jenkins

This just contains detils about this directory, the official instructions live here;

[Official Instructions](../BUILD_IN_JENKINS_FROM_GITHUB.md)

Also these commands might come in handy;

On Windows in Git Bash;
```
winpty docker exec -it -u root <containerId/> bash
```
On Max Os or other Unix
```
docker exec -it -u root <containerId/> bash
```
Then 
```
cat /var/jenkins_home/secrets/initialAdminPassword
```
