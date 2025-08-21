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

  @override
  Widget build(BuildContext context) {
    scrollBehavior: const MaterialScrollBehavior()
    .copyWith(scrollbars: true);
    return Scrollbar(
      child: Scaffold(
        //Fix issue of scrolling!!!!!!!
      
        
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row (
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
              ElevatedButton(onPressed: onPressed, child: const Text("Login")),
              TextButton(onPressed: onPressed, child: const Text("cart"))
            ],
          ),
        ),
        body: Center (
          child : Column(
            children: const <Widget>[SizedBox(height:300),],
          ),

        ),
        
        bottomNavigationBar: NavigationBar(
          height: 300,
          backgroundColor: Colors.black,
          destinations: const <Widget> [
            Column(
              children: <Widget>[
                Text("Next", style: TextStyle(backgroundColor: Colors.white),),
                Text("Next", style: TextStyle(backgroundColor: Colors.white),),
                Text("Next", style: TextStyle(backgroundColor: Colors.white),),
                Text("Next", style: TextStyle(backgroundColor: Colors.white),),
                Text("Next", style: TextStyle(backgroundColor: Colors.white),),],),
            Text("Up", style: TextStyle(backgroundColor: Colors.white),),
            Text("Down", style: TextStyle(backgroundColor: Colors.white),)
          ]
        ),
      
      ),
    );
  }

  void onPressed() {
    _incrementCounter();
  }
}
