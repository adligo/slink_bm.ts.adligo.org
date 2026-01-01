# Workflow 6) Build in Jenkins from Local Git Repositories

In order to use this work flow you must setup Jenkins on your local machine (with out Docker).  

### Jenkins Setup Notes

You will need to install Java, follow the instructions here;

[https://openjdk.org/](https://openjdk.org/)

I suggest installing Jenkins by simply downloading the jenkins.war file and using GitBash to run it with a command like;

```
java -jar jenkins.war --enable-future-java --httpPort=8081
```

## Creating Local Repositories

You will need to clone the GitHub repositories locally and then also push to those repositories;

Repository List

```
slink_bm.ts.adligo.org
slink_group.ts.adligo.org
slink_group_deps.ts.adligo.org
i_io.ts.adligo.org
i_obj.ts.adligo.org
i_strings.ts.adligo.org
i_tests4ts_types.ts.adligo.org
i_tests4ts.ts.adligo.org
junit-xml-tests4j_tests.ts.adligo.org
junit-xml-tests4j.ts.adligo.org
slink_tests.ts.adligo.org
slink.ts.adligo.org
tests4ts_tests.ts.adligo.org
tests4ts.ts.adligo.org
type-guards_tests.ts.adligo.org
type-guards.ts.adligo.org
```

Create a repositories folder and work directory on your local disk;

```
mkdir ~/my_repos
mkdir ~/my_work
```

For each repository create a local repository, clone it from git hub, add a remote link to the local repository and push to the local repository (known as a remote to the git program).

```
#create the local repository
mkdir ~/my_repos/slink_bm.ts.adligo.org
cd ~/my_repos/slink_bm.ts.adligo.org
git init --bare

# clone the repository from git hub
cd ~/my_work
git clone https://github.com/adligo/slink_bm.ts.adligo.org.git

#add a remote link to the local repository
cd ~/my_work/slink_bm.ts.adligo.org
git remote add home ~/my_work/slink_bm.ts.adligo.org

#push to the local repository 
git push home
```

Since there are 15 repositories this will take some time.  Eventually the Fabricate tool (fab on the cli) will help with this.

## Creating the Jobs in Jenkins








##### Note:

This is the build that would be used by library maintainers in order to make sure that changes to libraries don't break downstream projects (projects that require the dependency), before pushing to [GitHub](https://github.com/adligo) and [Npmjs.com](https://www.npmjs.com/).