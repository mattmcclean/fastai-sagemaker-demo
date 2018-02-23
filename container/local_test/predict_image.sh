#!/bin/sh

file=$1

curl -X POST -d @${file} -H "Accept: application/json" -H "Content-Type: application/x-image" http://localhost:8080/invocations 
