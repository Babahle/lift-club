import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/bookings_view_model.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/home.dart';
import 'package:lifts_app/pages/sign_in.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:lifts_app/themes/main_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider()
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LiftsViewModel()),
      ChangeNotifierProvider(create: (context) => AuthenticationService()),
      ChangeNotifierProvider(create: (context) => BookingViewModel()),
      FutureProvider<List<Lift>>(
        create: (context) =>  Provider.of<LiftsViewModel>(context, listen: false).getAllLifts(), initialData: [])
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lifts',
        theme: MainTheme.mainTheme,
        home: Consumer<AuthenticationService>(
          builder: (context, service, child) {
            return (service.checkIfLoggedIn())
                ? const MyHomePage(title: "Lifts")
                : SignInView();
          },
        ));
  }
}
