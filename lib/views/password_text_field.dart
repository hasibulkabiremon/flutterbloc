import 'package:flutter/material.dart';
import 'package:flutter_block_1/strings.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      // obscuringCharacter: '🧘🏻‍♂️',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}