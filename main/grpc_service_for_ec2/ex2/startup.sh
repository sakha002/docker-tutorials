#!/bin/bash

# service httpd start
# rc-service apache2 start

/usr/sbin/httpd -D FOREGROUND &

/go/bin/app