package jwt;

/**
 List of signature algorithms that could be used to sign / verify tokens with
 */
@:enum abstract JWTAlgorithm(String) {
    /**
     HMAC SHA256
     */
    var HS256 = "HS256";
}