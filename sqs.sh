#! /bin/bash

echo "-----------------START-------------------"

ROOP=$1
PROFILE=$2
URL=$3

echo "profile:" $PROFILE
echo "url:" $URL


cnt=0

while [ $cnt -lt $ROOP ];
do
  RESULT=`aws sqs receive-message --queue-url $URL --max-number-of-message "10" --profile $PROFILE --visibility-timeout 60`
  echo $RESULT >> ./sqs-out.txt
  cnt=$(( cnt + 1 ))
  echo $cnt
done
echo "-----------------END-------------------"
