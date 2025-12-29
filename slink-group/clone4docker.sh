./buildSrc/cloneOrPullDeps.sh
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "cloneOrPullDeps.sh executed sucessfully"
  fi
else
  echo "There was a problem with the cloneOrPullDeps.sh script"
  exit 35
fi

./buildSrc/cloneOrPullLibs.sh
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "cloneOrPullLibs.sh executed sucessfully"
  fi
else
  echo "There was a problem with the cloneOrPullLibs.sh script"
  exit 35
fi