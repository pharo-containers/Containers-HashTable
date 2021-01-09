# Containers-HashTable

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
![https://github.com/pharo-containers/Containers-HashTable/workflows/matrix/badge.svg](https://github.com/pharo-containers/Containers-HashTable/workflows/matrix/badge.svg)
![https://github.com/pharo-containers/Containers-HashTable/workflows/currentStablePharo/badge.svg](https://github.com/pharo-containers/Containers-HashTable/workflows/currentStablePharo/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/pharo-containers/Containers-HashTable/badge.svg?branch=master)](https://coveralls.io/github/pharo-containers/Containers-HashTable?branch=master) 

This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.

## Loading

```
Metacello new
  baseline: 'ContainersHashTable';
  repository: 'github://pharo-containers/Containers-HashTable/src';
  load.
```

## If you want to depend on it

```
  spec 
    baseline: ''ContainersHashTable' 
    with: [ spec repository: 'github://pharo-containers/Containers-HashTable/src' ].
  ```

----
The best way to predict the future is to do it!
Less talking more doing. stephane.ducasse@inria.fr
