#!/bin/bash
VMID=$1
PHASE=$2

if [ -z $VMID ] || [ -z $PHASE ]
then
  echo 'Error: CPU Pining not set';
  exit 1;
fi

if [ "${VMID}" -eq 900 ]
then
  CPUSET="0-13"
else
  CPUSET="0-27"
fi

if [ "${PHASE}" == "post-start" ]
then
    MAIN_PID="$(< /run/qemu-server/${VMID}.pid)"
    taskset --cpu-list --all-tasks --pid "${CPUSET}" "${MAIN_PID}"
fi

echo 'CPU Pining set OK';
