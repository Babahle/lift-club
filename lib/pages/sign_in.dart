import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const SignInScreen(
      providerConfigs: [
        EmailProviderConfiguration()
      ],
    );
  }
}
