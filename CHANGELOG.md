## CHANGELOG

### 1.11.0 (unreleased)

- Unicode 15.0

### 1.10.0

- Unicode 14.0

### 1.9.0

- Unicode 13

### 1.8.0

* Unicode 12.1

### 1.7.1

* Push unicode-types dependency to 1.4.0

### 1.7.0

* Unicode 12

### 1.6.0

* Unicode 11
* Do not depend on rubygems (only use zlib stdlib for unzipping)

### 1.5.2

* Explicitly load rubygems/util, fixes regression in 1.5.1

### 1.5.1

* Use `Gem::Util` for `gunzip`, removes deprecation warning

### 1.5.0

* Unicode 10

### 1.4.2

* Fix that Unicode::Name.correct would not fail if codepoint has aliases but no correction

### 1.4.1

* Be compatible with Ruby 2.4's surrogate literals
* Bump unicode-types dependency

### 1.4.0

* Support Hangul Syllables

### 1.3.0

* Support Unicode 9.0

### 1.2.0

* Support CJK Ideographs

### 1.1.0

* Support codepoint labels

### 1.0.0

* Initial release

