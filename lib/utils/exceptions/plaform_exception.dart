class ZPlatformException implements Exception{

  final String code;
  ZPlatformException(this.code);

  String get message{

    switch(code){
      case 'INVALID-LOGIN-CREDENTIALS':
        return 'Invalid Login Credentials. Please double check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-arguments':
        return 'Invalid Argument provided to the authentication method';
      default:
        return 'An Unexpected Firebase Error occurred. Please try again later.';
    }

  }

}