# Workflow 1) Build Everything Locally

This workflow requires that you setup your machine with node and GitBash;

Step 1) [Install Node.js](https://nodejs.org/en/download) click on the nodejs.org link at the left and follow the installation instructions.  I was on version v24.2.0 when I wrote this but any version after that should work as well.

Step 2) [Install GitBash](https://git-scm.com/install/) click on the git-scm.com link at the left and follow the installation instructions.  I was on version v2.51.2 (ReleaseNotes.html where you installed it) when I wrote this but if you install GitBash it will auto update often and keep you on a current version which should work well.

Step 3) Clone this repository from github.com from the GitBash command prompt with the following command;

```
git clone https://github.com/adligo/slink_docker.ts.adligo.org.git
```

Step 4) Download the dependencies;

```
cd slink-group
./setup_from_github.sh
```

The above script should take a few minutes as it clones a lot of other repositories, it should look something like the following;

![Picture of Steps 3-4](BuildEveythingSteps3-4.png)

 

##### Note:

This is used to build (and potentially release) all of the Adligo.org dependencies used by SLink.  This was the way all of the SLink code and dependencies were originally created.
