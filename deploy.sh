#!/bin/bash

if [ -z "$1" ]
  then
    echo "USAGE: $0 deploymentFile"
    echo "Example: $0 k8s/golang-mysql.yaml"
    exit 1
fi

if [ -f $1 ]
then
    images=`cat $1  | grep image | awk '{print $2}'`
else
    echo "File $1 not found" 
    exit
fi

echo ====================================
echo "Deploy using following images (y/n)?"
echo ====================================
echo "$images"

read answer

case "$answer" in
    [yY][eE][sS]|[yY])
        echo "Please wait for deployment. In progress..."
	kubectl apply -f $1
        ;;
    [nN][oO]|[nN])
        echo "Version of the new <calinrus/golang-api> image to build and use(eg: 1.0):"
        read answer_goimage_version

        echo "Version of the new <calinrus/mariadb> image to build and use(eg: 1.0):"
        read answer_mariadbimage_version

        docker build -t calinrus/golang-api:$answer_goimage_version . -f dockerfiles/Dockerfile_go
        docker push calinrus/golang-api:$answer_goimage_version
        docker build -t calinrus/mariadb:$answer_mariadbimage_version . -f dockerfiles/Dockerfile_db
        docker push calinrus/mariadb:$answer_mariadbimage_version

        sed -i "s@image: calinrus/golang-api:...@image: calinrus/golang-api:${answer_goimage_version}@g" $1
        sed -i "s@image: calinrus/mariadb:...@image: calinrus/mariadb:${answer_mariadbimage_version}@g" $1

        kubectl apply -f $1
        ;;
    *)
       echo "Not a valid option"
esac
