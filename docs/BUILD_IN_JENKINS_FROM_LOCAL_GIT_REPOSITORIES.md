# Workflow 6) Build in Jenkins from Local Git Repositories

In order to use this work flow you must setup Jenkins on your local machine (with out Docker).  

### Windows Install / Setup Notes

I suggest installing Jenkins by simply downloading the jenkins.war file and using GitBash to run it with a command like;

```
java -jar jenkins.war --enable-future-java
```



### Unix Install / Setup Notes

TODO

## Creating the Jobs

Use the password from the console and create a Freestyle Project with the name;

```
slink-bm.ts.adligo.org_<your_drive_letter>
i.e.
slink-bm.ts.adligo.org_p
```





## Export The LOCAL_REPO_ROOT Environment Variable

Add a Execute Shell build step and export the LOCAL_REPO_ROOT environment variable for your build.  Note if you have multiple drives you may need to change this to <DriveLetter/>_REPO_ROOT.  

```
export LOCAL_REPO_ROOT=~/repos/ts-org/
```

## The Build Scripts


##### Note:

This is the build that would be used by library maintainers in order to make sure that changes to libraries don't break downstream projects (projects that require the dependency), before pushing to [GitHub](https://github.com/adligo) and [Npmjs.com](https://www.npmjs.com/).