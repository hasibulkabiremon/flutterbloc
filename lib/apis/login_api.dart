import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_block_1/models.dart';

@immutable
abstract class LoginApiProtocall {
  const LoginApiProtocall();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocall {
  // // singleton pattern
  // const LoginApi._sharedInstance();
  // static const LoginApi _shared = LoginApi._sharedInstance();

  // factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(const Duration(seconds: 2),
              () => email == 'foo@bar.com' && password == 'foobar',)
          .then((isLoggedIn) => isLoggedIn ? const LoginHandle.foobar() : null);
}
