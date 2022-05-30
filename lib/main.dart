import 'package:firebase_core/firebase_core.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<DatabaseManager>(create: (_) => DatabaseManager())
        ],
        child: MaterialApp(
          title: 'Five-O Car Rental',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          initialRoute: Routes.login,
          onGenerateRoute: Routes.createRoute,
        ));
  }
}
