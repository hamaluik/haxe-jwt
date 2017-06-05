package jwt;

typedef JWTPayloadBase = {
    /**
     *  Issuer
     */
    @:optional var iss:String;

    /**
     *  Expiration time
     */
    @:optional var exp:Int;

    /**
     *  Subject
     */
    @:optional var sub:String;

    /**
     *  Audience
     */
    @:optional var aud:String;

    /**
     *  Issued at time
     */
    @:optional var iat:Int;
};