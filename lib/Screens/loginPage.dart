
import 'package:flutter/material.dart';
import 'package:middle_man/Screens/customer_Details.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  
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
