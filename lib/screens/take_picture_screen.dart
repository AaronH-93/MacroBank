import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:macro_bank/screens/home_screen.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  static final id = 'take_picture_screen';
  static String userAvatar;
  static String blankAvatar = 'assets/images/blank_avatar.png';
  static bool userHasAvatar = false;
  final CameraDescription camera;

  CameraScreen({this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  //initState will initialise the _controller as the camera
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  //dispose will dispose the camera when its finished, to save memory.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            //Tapping the button on the camera screen will take a picture
            await _initializeControllerFuture;
            //result will be the path and name the image will be saved to
            String result = join((await getApplicationDocumentsDirectory()).path, '${DateTime.now()}.png');
            await _controller.takePicture(result);
            //When a picture is taken, the user avatar is set to the picture we just took
            //and userHasAvatar is set to true, this tells the ternary operator in the home
            //screen class to use the new avatar.
            setState(() {
              CameraScreen.userAvatar = result;
              CameraScreen.userHasAvatar = true;
            });
            Navigator.pushNamed(context, HomeScreen.id);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

