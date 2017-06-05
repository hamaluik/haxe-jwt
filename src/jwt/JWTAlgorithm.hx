package jwt;

@:enum abstract JWTAlgorithm(String) {
    var HS256 = "HS256";
    var RS256 = "RS256";
}