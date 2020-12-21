import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Bluetooth/ble.dart';
import 'package:flutter_scan_bluetooth_example/Landing/tab_bar.dart';
import 'package:flutter_scan_bluetooth_example/Login/login.dart';
import 'package:flutter_scan_bluetooth_example/Self-assess/selfassess_content.dart';
import 'package:flutter_scan_bluetooth_example/nearby_interface.dart';

import 'package:flutter_scan_bluetooth_example/start/start_up.dart';

import 'Registration/registration.dart';

Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(XYZ());
}

class XYZ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        '/': (context) => Start_up(),
    // '/': (context) => BLE(),
        '/ble': (context) => NearbyInterface(),
        '/sss': (context) => SelfAssessContent(0x87938f),
        '/login': (context) => LoginView(),
        '/tab-bar': (context) => Tab_Bar(),
        '/registration': (context) => Registration(),
      },
    );
  }
}
