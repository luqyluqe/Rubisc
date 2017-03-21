#!/bin/bash

if [ ! -n "$1" ] ;then
	echo "Usage: pod-publish <version>"
    echo "Example: pod-publish 0.1.0"
	exit
fi 

path=$PWD
proj_name=${path##*/}
cd ~/.cocoapods/repos/$proj_name
git reset --hard head
cd $path
substitute $proj_name.podspec s.version.*=.* s.version="'$*'"
git add .
git commit -m $*
git tag $*
git push origin master --tags
pod repo push $proj_name $proj_name.podspec --verbose --allow-warnings --use-libraries
git pull origin master
versions_path=~/.cocoapods/repos/$proj_name/$proj_name
rm -rf $versions_path/Assets/
rm -rf $versions_path/Classes/
