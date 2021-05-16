import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/home.dart';
void main(){
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
  runApp(
    MaterialApp(
      home: SplashScreen(),
    )
  );
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/images/spsc.jpg'),
          fit: BoxFit.cover
        )
      ),
    );
  }
  Future<Timer> loadData() async{
    return new Timer(Duration(seconds: 3),onDoneLoading);
  }
  onDoneLoading() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyApp()));
  }
}
