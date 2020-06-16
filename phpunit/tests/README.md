# Testing notes and caveats

* Always install php unit by composer
* Currently: phpunit ^9, PHP ^7.4

## Note!

To speed up tests and perform unit tests and integration at the same run I use a present Redaxo 5.10.x installation reachable under http://localhost/tk/tth-rex. Hence some _tests cannot be run without this Redaxo_

Use [test.sh](./test.sh) for independent unit test (May fail because mock objects are incomplete).

