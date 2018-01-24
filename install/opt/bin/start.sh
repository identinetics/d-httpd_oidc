#!/bin/bash

rm -f /run/httpd/* 2>/dev/null
httpd -DFOREGROUND -d /etc/httpd/ -f conf/httpd.conf
