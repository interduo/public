#!/bin/bash
exit

#check all drives Power_On_Hours and Wareout
for i in `ls /dev/disk/by-id/* | grep -v part`; do echo $i; smartctl -a --device=sat $i | grep -E 'Power_On_Hours|231 Unknown_SSD_Attribute'; done
