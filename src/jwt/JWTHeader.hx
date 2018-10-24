package jwt;

/**
 Contents of the JWT header
 */
typedef JWTHeader = {
    /**
     Signature algorithm
     */
    @:optional var alg:JWTAlgorithm;

    /**
     Token type
     */
    @:optional var typ:JWTType;
};