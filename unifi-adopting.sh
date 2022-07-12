#!/bin/bash

if [ -z "$1" ]
then
  echo 'brak podanego IP';
  exit 1;
fi

ssh ubnt@$1 -oHostKeyAlgorithms=+ssh-dss 'set-inform http://unifi.interduo.pl:8080/inform'
