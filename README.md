# haxe-jwt

A [JSON Web Token](https://jwt.io/#debugger) library for native [Haxe](http://haxe.org/).

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

## Changelog

