#!/bin/bash

# sudo docker run --interactive --tty --rm --volume /home/thomask/Dokumente/kwd21linux/redaxo-mit-docker/tth-rex/phpunit/tests:/code "nubs/phpunit table_manager.Test.php"
sudo docker run --interactive --tty --volume /home/thomask/Dokumente/kwd21linux/redaxo-mit-docker/tth-rex/phpunit/tests:/code nubs/phpunit 
# sudo docker run --interactive --tty --volume /home/thomask/Dokumente/kwd21linux/redaxo-mit-docker/tth-rex/phpunit:/code nubs/phpunit