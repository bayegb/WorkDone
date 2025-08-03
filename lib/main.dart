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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Middle Man'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color:  Color.fromARGB(255, 235, 233, 233),
              child: SizedBox( 
                width: 150,
                child:
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: usernameController,
                    decoration: const InputDecoration(hintText: 'Username', 
                      //contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0,),
                        ),
                    validator: (String? value) {
                      if(value == null || value.isEmpty){
                        return 'Enter your Username please.';
                      }
                      return null;
                    }
                  ),  
              ),
            ),
            
            SizedBox (height: 40),

            Container(
              color:  Color.fromARGB(255, 235, 233, 233),
              //decoration: ,
              child: SizedBox(
                width: 150,
                child: TextFormField(
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'Password',),
                    validator: (String? value) {
                    if(value == null || value.isEmpty){
                      return 'Enter your Password please.';
                    }
                      return null;
                    }
                  )
              ),
            ),
            
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            SizedBox (height: 20),
            // Text(
            //   '$_counter'+' '+passwordController.text+' '+usernameController.text,
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),

            SizedBox(
              width: 80,
              child: TextButton(
                onPressed://_incrementCounter, // add transition to the next page here 
                //tooltip: '',
                 () { // LEARN HOW TO USE THE GOROUTE
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CustomerDetails()),
                  );
                 },
                child: const Text('Login', selectionColor: Color.fromARGB(255, 255, 255, 255)),
        
              ),
            ),
          ],
          
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
