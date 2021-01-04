import 'package:flutter/material.dart';
import 'package:macro_bank/screens/take_picture_screen.dart';
import 'package:macro_bank/screens/transfer_screen.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/pot_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//A few functions of the app require the use of asynchronous functions, thus you will see the async and await keywords
//mostly regarding Firebase or the camera.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //App comes with firebase authentication, users can register and log in to an account.
  await Firebase.initializeApp();

  //Camera is initialised here and when the camera screen is built
  //the camera is passed with it in the route.
  final cameras = await availableCameras();
  final rearCam = cameras.last;

  runApp(MacroBank(camera: rearCam));
}

class MacroBank extends StatelessWidget {

  final camera;

  MacroBank({this.camera});

  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider is what lets us manage the state of the app and the PotData class
    //It is part of the provider package and lets us update the state of the app when changes are made to
    //the PotData() class.
    return ChangeNotifierProvider(
      builder: (context) => PotData(),
      child: MaterialApp(
        //Internalisation
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('de', ''), // German
          const Locale.fromSubtags(languageCode: 'de'),
        ],
        //Screen Routes
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          //Camera object sent into CameraScreen
          CameraScreen.id: (context) => CameraScreen(camera: camera),
          TransferScreen.id: (context) => TransferScreen(),
        },
      ),
    );
  }
}
