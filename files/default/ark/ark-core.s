#!/bin/sh /usr/sbin/arkconfigs
#

# common areas
ark /etc 
ark /usr/local local
ark /home/
ark /root

# various standard state commands
cmd df-list df -fh
cmd pci-list lspci -v
cmd ip-addresses /sbin/ip addr
cmd rpm-list rpm -qa
