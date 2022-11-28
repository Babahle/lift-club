import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lifts_app/pages/home.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: const [EmailProviderConfiguration()],
      actions: [
        AuthStateChangeAction<SignedIn>((context, _) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "Lifts")));
        }),
      ],
    );
  }
}
