#!/bin/bash

sed -i -e "s/DBTYPE/$DBTYPE/g" -e "s/DBHOST/$DBHOST/" -e "s/DBUSER/$DBUSER/" -e "s/DBNAME/$DBNAME/" -e "s/DBPASS/$DBPASS/" -e "s/DBPORT/$DBPORT/" -e "s/SELFURLPATH/$SELFURLPATH/" /var/www/html/Tiny-Tiny-RSS/config.php
