#!/bin/bash

if [[ $# -ne 1 || ! "$1" =~ ^[0-9]+$ ]]; then
    echo "Użycie: $0 PID" >&2
    exit 1
fi

pid="$1"

if [[ ! -r "/proc/$pid/cgroup" ]]; then
    echo "Nie znaleziono PID $pid" >&2
    exit 1
fi

ctid=$(grep -oE '(^|/)(lxc/)?[0-9]+(\.scope)?$' "/proc/$pid/cgroup" |
    grep -oE '[0-9]+' | head -n1)

if [[ -z "$ctid" ]]; then
    echo "Nie udało się ustalić CT dla PID $pid" >&2
    exit 1
fi

name=$(pct list | awk -v id="$ctid" '$1 == id {print $3; exit}')

if [[ -n "$name" ]]; then
    echo "$name"
else
    echo "CT $ctid"
fi
