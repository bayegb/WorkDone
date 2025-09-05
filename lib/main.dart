import 'package:flutter/material.dart';
import 'package:middle_man/Screens/customer_Details.dart';
import 'package:middle_man/Screens/loginPage.dart';
// ignore: depend_on_referenced_packages
import 'package:middle_man/Widgets/BottomNavigationBar.dart';

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

// class BottomNavigationBarItem {
//   const BottomNavigationBarItem
//   ),

// }
class _WelcomePageState extends State<WelcomePage> {
  int _counter = 0;
  //Username and Password
  final searchBarController = TextEditingController();
  final passwordController = TextEditingController();
  
 

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed.
    searchBarController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
//NOW FOLLOW EVERYTHING THAT IS ON THE FIGMAPROTOTYPE, SO THAT YOU HAVE SOMETHING TO SHOW VONGANI ,THEN IMPROVE LATER !!!!!!!!!!!!!!!!!
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title),
            SizedBox(width: 10,),
            SizedBox(
              width: 100,
              child: TextFormField (
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "search",
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255)
                ),
              ),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context)=>LoginPage(title: 'yes')));}, 
              child: const Text("Login")
            ),
            TextButton(onPressed: onPressed, child: const Text("cart"))
          ],
        ),
      ),

      body: Stack(
        children:<Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/peopleWaitingForTaxi.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text('YES'),
        ]
      ),

      
      //sort out issue of this Navigation Bar and start with the GoRoute
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("LERYSS (Pty) Ltd CopyRight 2025", style: TextStyle(color: Colors.white)),
          ],
        )
      )
      
    );
  }

  void onPressed() {
    _incrementCounter();
  }
}
