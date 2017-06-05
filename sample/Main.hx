import Sys;
import jwt.JWT;

typedef TPayload = {
    var adm:Bool;
};

class Main {
    public static function main():Void {
        var payload:TPayload = {
            adm: true
        };

        var token:String = JWT.sign(payload, "derp");
        Sys.println('Generated valid token: ${token}');

        var fakeToken:String = JWT.sign({ adm: true }, 'password1');
        Sys.println('Testing token: ${fakeToken}');
        var test1:JWTResult<TPayload> = JWT.verify(fakeToken, 'derp');
        switch(test1) {
            case Valid(p): Sys.println("  token is valid! is admin: " + p.adm);
            case Invalid: Sys.println("  invalid token!");
        }

        Sys.println('Testing valid token: ${token}');
        var test2:JWTResult<TPayload> = JWT.verify(token, 'derp');
        switch(test2) {
            case Valid(p): Sys.println("  token is valid! is admin: " + p.adm);
            case Invalid: Sys.println("  invalid token!");
        }
    }
}