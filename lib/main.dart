
import 'package:flutter/material.dart';
import 'package:travelapp/mainFiles/socialhome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelapp/views/social_login.dart';
import 'firebase_options.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
            MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
             LoginScreen.id:(context) => LoginScreen(),
            },
           initialRoute: LoginScreen.id,
          );
        }
      
  }
