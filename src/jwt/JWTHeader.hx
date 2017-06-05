package jwt;

typedef JWTHeader = {
    /**
     *  Signature algorithm
     */
    var alg:JWTAlgorithm;

    /**
     *  Token type
     */
    var typ:JWTType;
};