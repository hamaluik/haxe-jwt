package jwt;

/**
 The type of the token
 (it should always be 'JWT'!)
 */
@:enum abstract JWTType(String) {
    var JWT = "JWT";
}