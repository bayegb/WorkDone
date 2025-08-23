import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  
  BottomNavBar () {
    String id;
    super.key; 
  } 
  String id = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("Next", style: TextStyle(color: Colors.white)),
            Text("Up", style: TextStyle(color: Colors.white)),
            Text("Down", style: TextStyle(color: Colors.white)),
          ],
        )
      ),
      )
    );
  }
}