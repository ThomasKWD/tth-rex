# Testing notes and caveats

## Testing with Docker (recommended)

For making config easier (and maybe test other stuff in `theme/` too) the Docker volume is mounted to `lib/`.

Hence run it from there. Just execute `theme/private/runphpunit.sh`.

This version gets around without Redaxo and thus needs a considerable amount of mocks and stubs.

## Testing with local PHPUnit install

* Always install php unit by composer
* Currently: phpunit ^9, PHP ^7.4

To speed up tests and perform unit tests and integration at the same run I use a present Redaxo 5.10.x installation reachable under http://localhost/tk/tth-rex. Hence some _tests cannot be run without this Redaxo_

Use [test.sh](./test.sh) for independent unit test (May fail because mock objects are incomplete).

