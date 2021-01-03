import 'package:flutter/material.dart';
import 'package:macro_bank/screens/take_picture_screen.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/currency_data.dart';
import 'screens/edit_currency_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final cameras = await availableCameras();
  final rearCam = cameras.last;

  runApp(MacroBank(camera: rearCam));
}

class MacroBank extends StatelessWidget {

  final camera;

  MacroBank({this.camera});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => CurrencyData(),
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          CameraScreen.id: (context) => CameraScreen(camera: camera),
          EditCurrencyScreen.id: (context) => EditCurrencyScreen()
        },
      ),
    );
  }
}
