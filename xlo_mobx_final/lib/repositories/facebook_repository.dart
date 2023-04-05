import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookRepository {
  Future<Map<String, dynamic>> login() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      await FacebookAuth.instance.logOut();
    }

    final resultFacebookLogin = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);

    switch (resultFacebookLogin.status) {
      case LoginStatus.success:
        final String token = resultFacebookLogin.accessToken.token;
        final DateTime dateExpiration = resultFacebookLogin.accessToken.expires;

        final userData = await FacebookAuth.instance.getUserData();
        final Map<String, dynamic> authData = <String, dynamic>{};

        authData['id'] = userData['id'];
        authData['access_token'] = token;
        authData['expiration_date'] = dateExpiration.toString();

        if (userData.containsKey('email')) {
          authData['email'] = userData['email'];
        }

        if (userData.containsKey('name')) {
          authData['name'] = userData['name'];
        }

        await FacebookAuth.instance.logOut();
        return authData;
      case LoginStatus.cancelled:
        return Future.error('Login cancelado');
      case LoginStatus.failed:
        return Future.error(resultFacebookLogin.message);
      case LoginStatus.operationInProgress:
        break;
      default:
        return Future.error('Algo inesperado aconteceu');
    }
    return null;
  }
}
