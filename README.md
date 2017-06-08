# haxe-jwt

[![GitHub license](https://img.shields.io/badge/license-Apache%202-blue.svg?style=flat-square)](https://raw.githubusercontent.com/FuzzyWuzzie/haxe-jwt/master/LICENSE)

A [JSON Web Token](https://jwt.io/#debugger) library for native [Haxe](http://haxe.org/).

API docs are available here: [https://fuzzywuzzie.github.io/haxe-jwt/](https://fuzzywuzzie.github.io/haxe-jwt/).

## Features

* Signing (generating) tokens
    + Limited to HS256 algorithm for now
* Verifying (& decoding) tokens
    + Limited to HS256 algorithm for now
    + Does not check any public claims (exp, iss, sub, etc) yet

## Usage

The library exposes two main functionalities: _signing_ tokens and _verifying_ tokens.

### Signing Tokens

```haxe
import jwt.JWT;

// ...

var token:String = JWT.sign({ adm: true }, "my super secret secret");
```


### Verifying Tokens

```haxe
import jwt.JWT;

typedef TPayload = {
    > jwt.JWTPayloadBase,
    var adm:Bool;
}

// ...

var result:JWTResult<TPayload> = JWT.verify(token, "my super secret secret");
switch(result) {
    case Valid(payload): {
        trace(payload);
    }

    case Invalid: throw 'The token was invalid, you dummy!';
}

```

## Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

### 1.1.0
#### Added
- A `replacer` parameter to `JWT.sign`, allowing custom replacers for JSON encoding (through `haxe.Json.encode`).

#### Fixed
- Actually fixed `haxelib.json` `classpath` :sweat_smile:

### 1.0.1
#### Changed
- Attempted to fix `haxelib.json` `classpath` so library can _actually_ be used.

### 1.0.0
#### Added
- HMACSHA256 token generation & signing
- HMACSHA256 token verification & decoding
