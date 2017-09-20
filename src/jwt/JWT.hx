package jwt;

import haxe.Json;
import haxe.crypto.Base64;
import haxe.crypto.Hmac;
import haxe.io.Bytes;

using StringTools;

/**
 The result of a call to JWT.verify.
 If the token is valid and the signatures match, it contains the payload.
 */
enum JWTResult<T:Dynamic> {
    /**
     The token signature is valid, included is the payload
     */
    Valid(payload:T);

    /**
     The signature was invalid
     */
    Invalid(payload:T);

    /**
     *  The token was malformed
     */
    Malformed;
}

/**
 All JWT functionality is implemented here (namely signing and verifying tokens)
 */
class JWT {
    private function new(){}

    private static function base64url_encode(b:Bytes):String {
        var b64:String = Base64.encode(b);
        return b64.replace('+', '-').replace('/', '_').replace('=', '');
    }

    private static function base64url_decode(s:String):Bytes {
        var s64 = s.replace('-', '+').replace('_', '/');
        s64 += switch(s64.length % 4) {
            case 0: '';
            case 1: '===';
            case 2: '==';
            case 3: '=';
            case _: throw 'Illegal base64url string!';
        }
        return Base64.decode(s64);
    }

    private static function signature(alg:JWTAlgorithm, body:String, secret:String):Bytes {
        if(alg != JWTAlgorithm.HS256) throw "HS256 is the only supported algorithm for now!";

        var hmac:Hmac = new Hmac(HashMethod.SHA256);
        var sb:Bytes = hmac.make(Bytes.ofString(secret), Bytes.ofString(body));
        return sb;
    }

    /**
     Creates a signed JWT
     @param header - header information. If null, will default to HS256 encryption
     @param payload - The data to include
     @param replacer -  If `replacer` is given and is not null, it is used to retrieve the
	                    actual payload to be encoded. The `replacer` function takes two parameters,
	                    the key and the value being encoded. Initial key value is an empty string.
     @see <http://api.haxe.org/haxe/Json.html#stringify>
     @param secret - The secret to generate the signature with
     @return String
     */
    public static function sign(payload:Dynamic, secret:String, ?replacer:Dynamic->Dynamic->Dynamic, ?header:JWTHeader):String {
        if(header == null) {
            header = {
                alg: JWTAlgorithm.HS256,
                typ: JWTType.JWT
            };
        }

        // for now
        header.alg = JWTAlgorithm.HS256;

        var h:String = Json.stringify(header);
        var p:String = Json.stringify(payload, replacer);
        var hb64:String = base64url_encode(Bytes.ofString(h));
        var pb64:String = base64url_encode(Bytes.ofString(p));
        var sb:Bytes = switch(header.alg) {
            case JWTAlgorithm.HS256: signature(header.alg, hb64 + "." + pb64, secret);
            default: throw 'The ${cast(header.alg)} algorithm isn\'t supported yet!';
        }
        var s:String = base64url_encode(sb);

        return hb64 + "." + pb64 + "." + s;
    }

    // TODO: add @:generic when https://github.com/HaxeFoundation/haxe/issues/3697 is sorted

    /**
     Verifies a JWT and returns the payload if successful
     @param jwt - the token to examine
     @param secret - the secret to compare it with
     @return JWTResult<T>
     */
    public static function verify<T:Dynamic>(jwt:String, secret:String):JWTResult<T> {
        var parts:Array<String> = jwt.split(".");
        if(parts.length != 3) return JWTResult.Malformed;

        var h:String = base64url_decode(parts[0]).toString();
        var header:JWTHeader = cast(Json.parse(h));
        if(header.alg != JWTAlgorithm.HS256) throw 'The ${cast(header.alg)} algorithm isn\'t supported yet!';

        var p:String = base64url_decode(parts[1]).toString();

        // verify the signatures match!
        var sb:Bytes = base64url_decode(parts[2]);
        var testSig:Bytes = signature(header.alg, parts[0] + "." + parts[1], secret);
        if(sb.compare(testSig) != 0) return JWTResult.Invalid(Json.parse(p));

        // TODO: validate public claims (iss, sub, exp, etc)

        return JWTResult.Valid(Json.parse(p));
    }

    /**
     Extracts the payload from a JWT, throwing an exception if it is malformed
     @param jwt - The token to extract from
     @return T
     */
    public static function extract<T:Dynamic>(jwt:String):T {
        var parts:Array<String> = jwt.split(".");
        if(parts.length != 3) throw 'Malformed JWT!';
        return Json.parse(base64url_decode(parts[1]).toString());
    }
}