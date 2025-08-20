import 'package:flutter/material.dart';
import 'package:middle_man/Screens/customer_Details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const WelcomePage(title: 'Middle Man'),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});
  
  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _counter = 0;
  //Username and Password
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //use the makro website as a template or guide !!!!!!!
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row (
          children: <Widget>[
            Text(widget.title),
            SizedBox(width: 10,),
            ElevatedButton(onPressed: onPressed, child: const Text("Login")),
            TextButton(onPressed: onPressed, child: const Text("cart"))
          ],
        ),
      ),
      body: Center (
      ),

    );
  }

  void onPressed() {
    _incrementCounter();
  }
}
