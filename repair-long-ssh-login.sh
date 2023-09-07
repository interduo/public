In /etc/pam.d/common-session on the machine you see slow logins for (ie. the server). 
Comment out the line session optional pam_systemd.so.
That should immediately fix the problem.
