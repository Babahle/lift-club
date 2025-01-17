import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/all_lifts.dart';
import 'package:lifts_app/pages/booked_lifts.dart';
import 'package:lifts_app/pages/create_lift.dart';
import 'package:lifts_app/pages/created_lifts.dart';
import 'package:lifts_app/pages/searched_lifts.dart';
import 'package:lifts_app/pages/sign_in.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:lifts_app/themes/main_theme.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  var screens = [
    const AllLiftsView(),
    const CreatedLiftsView(),
    const CreateLiftView(),
    const BookedLiftsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(builder: (context, liftsViewModel, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            elevation: 0.0,
            actions: [
              _buildSearchButton(),
              _buildSignOutButton(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: MyColors.widgetsBackground,
              unselectedItemColor: MyColors.body,
              selectedItemColor: MyColors.heading,
              selectedFontSize: 14.0,
              onTap: (index) => setState(() {
                    currentIndex = index;
                  }),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "Created Lifts"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: "Create New Lift"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check), label: "Booked")
              ]),
          body: screens[currentIndex]);
    });
  }

  Consumer<AuthenticationService> _buildSearchButton() {
    return Consumer<AuthenticationService>(builder: ((context, service, child) {
      return Consumer<LiftsViewModel>(
        builder: ((context, liftsModel, child) {
          return IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchedLifts(lifts: liftsModel.getAllLifts()));
            },
            icon: const Icon(Icons.search),
          );
        }),
      );
    }));
  }

  Consumer<AuthenticationService> _buildSignOutButton() {
    return Consumer<AuthenticationService>(builder: ((context, service, child) {
      return IconButton(
          onPressed: () {
            service.signOutUser();
             Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => SignInView()),
                (Route<dynamic> route) => false);
          },
          icon: const Icon(Icons.door_sliding));
    }));
  }
}
