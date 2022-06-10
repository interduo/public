#!/bin/bash
VMID=$1
PHASE=$2

if [ -z $VMID ] || [ -z $PHASE ]
then
  exit 1;
fi

if [ "${VMID}" -eq 900 ]
then
  CPUSET="0-13"
else
  CPUSET="14-27"
fi

if [ "${PHASE}" == "post-start" ]
then
    MAIN_PID="$(< /run/qemu-server/${VMID}.pid)"
    echo taskset --cpu-list --all-tasks --pid "${CPUSET}" "${MAIN_PID}"
fi
