import 'package:dashboard_tlpp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:dashboard_tlpp/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLogged = await verifyToken();

  String user = await getUser();

  runApp(MyApp(
    isLogged: true,
    user: 'user',
  ));
}

Future<bool> verifyToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //TODO: Criar uma classe de valores
  String? token = sharedPreferences.getString('first_name');
  if (token != null) {
    return true;
  }
  return false;
}

Future<String> getUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //TODO: Criar uma classe de valores
  String? user = sharedPreferences.getString('first_name');
  if (user != null) {
    return user;
  }
  return '';
}

class MyApp extends StatefulWidget {
  final bool isLogged;
  final String user;

  const MyApp({Key? key, required this.isLogged, required this.user})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void refresh() async {
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard TLPP',
      home: LoginScreen(),
      initialRoute: (widget.isLogged) ? "transfer" : "notLogged",
      routes: {
        "login": (context) => LoginScreen(),
        "dashboard": (context) => DashboardScreen(),
      },
      onGenerateRoute: (routeSettings) {},
    );
  }
}