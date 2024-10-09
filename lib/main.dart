import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screen/sensor_traking.dart';
import 'package:todo_app/screen/todo_list.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do & Sensor App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TodoListScreen(),
    SensorTrackingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.9,  // Set width to 328
              height: 76,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),  // Navigate to To-Do List screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding inside the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                  ),
                ),
                child: Text(
                  'A To-Do List',
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 16, // Font size
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.9,  // Set width to 328
              height: 76,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SensorTrackingScreen(),  // Navigate to Sensor Tracking screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F69FF),// Background color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding inside the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                  ),
                ),
                child: Text('Sensor Tracking',style: TextStyle(color: Colors.white,fontSize: 16,),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          // Add your onPressed functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan, // Background color
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding inside the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded edges
          ),
        ),
        child: Text(
          'A To-Do List',
          style: TextStyle(
            color: Colors.black, // Text color
            fontSize: 16, // Font size
          ),
        ),
      ),
    );
  }
}
