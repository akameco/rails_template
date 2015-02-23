#!/bin/sh
cd sample
spring stop
cd ..
rm -fr ./sample
rails new sample -m app_template.rb --skip-bundle -T
