#! /bin/bash
ROOP=$1
URL=$2
PROFILE=$3

echo "url:" $URL
echo "profile:" $PROFILE

function show_progress() {
  sleep 0.1
  bar="$(yes '#' | head -n $1 | tr -d '\n')"
  progress=`echo "scale=5; $1 / $2 * 100" | bc`
  printf "\r%.0f%s %s" $progress \% ${bar}
}

function receive_messages() {
  if [ -n "$STRING" ]; then
    echo `aws sqs receive-message --queue-url $1 --max-number-of-message "1" --profile $2 --visibility-timeout 60`
  else
    echo `aws sqs receive-message --queue-url $1 --max-number-of-message "1" --visibility-timeout 60`
  fi
}

cnt=0

while [ $cnt -lt $ROOP ];
do
  RESULT=`receive_messages $URL $PROFILE`
  echo $RESULT >> ./sqs-out.json
  cnt=$(( cnt + 1 ))
  show_progress $cnt $ROOP
done
