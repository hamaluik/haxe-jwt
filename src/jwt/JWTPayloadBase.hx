package jwt;

/**
 Base anonymous structure to optionally extend from
 @see <https://haxe.org/manual/types-structure-extensions.html>
 @see <https://jwt.io/introduction/#payload>
 */
typedef JWTPayloadBase = {
    /**
     Issuer
     */
    @:optional var iss:String;

    /**
     Expiration time
     */
    @:optional var exp:Int;

    /**
     Subject
     */
    @:optional var sub:String;

    /**
     Audience
     */
    @:optional var aud:String;

    /**
     Issued at time
     */
    @:optional var iat:Int;
};