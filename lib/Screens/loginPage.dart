
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
  //Username and Password controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  String userName = "";
  String password = "";

  void _storeValues() {
    setState(() {
      userName= usernameController.value.toString();
      password = passwordController.value.toString();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CustomerDetails()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),

      body: Stack(

        children: <Widget>[ 
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/V&AMALL.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
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
              
        
              SizedBox (height: 20),
        
              SizedBox(
                width: 80,
                child: TextButton(
                  onPressed: _storeValues,
                  //  () { // LEARN HOW TO USE THE GOROUTE
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => const CustomerDetails()),
                  //   );
                  // },
                  child: const Text('Login', selectionColor: Color.fromARGB(255, 255, 255, 255)),
          
                ),
              ),
            ],
            
          ),
        ),
        ]
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
