#
# This script is expected to be executed by GitBash or Jenkins
#
# Note the #!/bin/bash directive has been removed as Jenkins on Windows will complain about it
#

VEBOSE=false
SSL=false
while (( "$#" )); do
  #echo "$1"
  case "$1" in
    -l | --local-build) LOCAL_BUILD=true; shift 1 ;;
    -r | --local-repository-root) LOCAL_REPOSITORY_ROOT="$1"; shift 2 ;;
    -s | --ssl) SSL=true; shift 1 ;;
    -v | --verbose) VERBOSE=true; shift 1 ;;
  esac
done

function doCd() {
  cd $1
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully moved(changed) into $1"
    fi
  else
    echo "Unable to move(change) into $1"
    exit 28
  fi
  
}

function doLocalClone () {
  if [[ -d "$LOCAL_REPOSITORY_ROOT/slink_group.ts.adligo" ]]; then
      git clone $LOCAL_REPOSITORY_ROOT/slink_group.ts.adligo
  else
    echo "Unable to clone the following repository the path doesn't exist"
    echo $LOCAL_REPOSITORY_ROOT/slink_group.ts.adligo
    exit 39
  fi  
}

pwd
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "In dir ROOT_DIR;"
    $ROOT_DIR
  fi
else
  echo "Unable to identify the root path, ensure pwd is in your path!"
  exit 11
fi
ROOT_DIR=`pwd`


if [[ -d "slink_group.ts.adligo.org" ]]; then
  doCd slink_group.ts.adligo.org
  git pull
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "git pull sucessful in dir"
      pwd
    fi
  else
    echo "Git pull failed on project"
    echo "slink_group.ts.adligo.org"
    exit 38
  fi
else
  if [[ $SSL == "true" ]]; then
    git clone git@github.com:adligo/slink_group.ts.adligo.org.git
  elif [[ $LOCAL_BUILD == "true " ]]; then
    doLocalClone
  else
    git clone https://github.com/adligo/slink_group.ts.adligo.org.git
  fi
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "git clone sucessful in dir"
      pwd
    fi
  else
    echo "Git clone failed on project"
    echo "slink_group.ts.adligo.org"
    exit 51
  fi
  doCd slink_group.ts.adligo.org
fi

if [[ $LOCAL_BUILD == "true" ]]; then
  npm run git-clone-or-pull -- --LOCAL_REPOSITORY_ROOT $LOCAL_REPOSITORY_ROOT
else
  npm run git-clone-or-pull
fi
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "All projects sucessfully cloned or pulled in!"
    pwd
  fi
else
  echo "There was an issue cloning or pulling the git projects in;"
  echo "slink_group.ts.adligo.org!"
  exit 71
fi
