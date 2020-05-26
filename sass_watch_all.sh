#!/bin/sh

echo start editing your *.scss and dependencies . ..

node-sass ./theme/private/scss/ --output-style compressed --watch --output ./theme/public/assets
