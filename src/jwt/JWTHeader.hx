package jwt;

/**
 Contents of the JWT header
 */
typedef JWTHeader = {
    /**
     Signature algorithm
     */
    var alg:JWTAlgorithm;

    /**
     Token type
     */
    var typ:JWTType;
};