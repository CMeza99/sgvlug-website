#!/usr/bin/env bash
#
# File: bump.sh
# Desc: Help automate updating and deployment of website
# Date: 6/18/2016
# Author: Carlos Meza
#

# find path
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# check parameters
if [ ! -z $1 ]; then
  if [ "$1" == '--init' ]; then
    echo "lll"; pip install --requirement $DIR/requirements.txt
    (cd $DIR; git submodule init && git submodule update)
    (cd $DIR/meetup2md/ && git submodule init && git submodule update && pip install --requirement requirements.txt)
    exit $?
  fi
fi

echo 'Updated:' > $DIR/bump
date >> $DIR/bump

(cd $DIR; git add bump; git commit bump -m "updated via bump.sh"; git push)
