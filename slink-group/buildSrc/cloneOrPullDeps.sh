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
    -s | --ssl) SSL=true; shift 1 ;;
    -v | --verbose) VERBOSE=true; shift 1 ;;
  esac
done


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



if [[ -d "slink_group_deps.ts.adligo.org" ]]; then
  cd slink_group_deps.ts.adligo.org
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "In dir"
      pwd
    fi
  else
    echo "Unable to move (change) into the directory;"
    echo "slink_group_deps.ts.adligo.org"
    exit 26
  fi
  git pull
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "git pull sucessful in dir"
      pwd
    fi
  else
    echo "Git pull failed on project"
    echo "slink_group_deps.ts.adligo.org"
    exit 38
  fi
else
  if [[ $SSL == "true" ]]; then
      git clone git@github.com:adligo/slink_group_deps.ts.adligo.org.git
  else
      git clone https://github.com/adligo/slink_group_deps.ts.adligo.org.git
  fi
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "git clone sucessful in dir"
      pwd
    fi
  else
    echo "Git clone failed on project"
    echo "slink_group_deps.ts.adligo.org"
    exit 51
  fi
fi


npm install
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "npm install sucessful in dir"
    pwd
  fi
else
  echo "npm install failed on project"
  echo "slink_group_deps.ts.adligo.org"
  exit 66
fi