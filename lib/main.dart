import 'package:flutter/material.dart';
import 'package:socialchat/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "social network",
      theme: ThemeData(
          primaryColor: Colors.blue[400], accentColor: Colors.green[400]),
      debugShowCheckedModeBanner: false,
      home: FirebaseConfiguration(),
    );
  }
}

class FirebaseConfiguration extends StatelessWidget {
  static String routeName = 'firebaseConfiguration';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnappshot) {
          if (dataSnappshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnappshot.error.toString()),
              ),
            );
          }
          if (dataSnappshot.connectionState == ConnectionState.done) {
            // return Scaffold(
            //   body: Text('DONE'),
            // );
            return Home();
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
