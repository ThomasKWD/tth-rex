#!/bin/bash

# This file is just to note ideas for variants + save on writing + remember calls when on other machine.

# sudo docker run --interactive --tty --rm --volume /home/thomask/Dokumente/kwd21linux/redaxo-mit-docker/tth-rex/phpunit/tests:/code "nubs/phpunit table_manager.Test.php"

# not interactive

# my own autoloader
# sudo docker run -v $(pwd)/tests:/app --rm phpunit/phpunit myautoload.php 

# specifiy test file 
sudo docker run -v $(pwd)/lib:/app --rm phpunit/phpunit ./test
# sudo docker run -v $(pwd)/lib:/app --rm phpunit/phpunit ./test/view_formatter.Test.php

# TODO: specify everything needed by phpunit.xml