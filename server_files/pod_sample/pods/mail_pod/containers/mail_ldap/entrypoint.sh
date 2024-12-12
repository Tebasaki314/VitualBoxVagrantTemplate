#!/bin/bash

mkdir -p /home/mail
chmod o+w /home/mail
postfix start

# Keep the container running
tail -f /dev/null
