import 'package:flutter/material.dart';
import 'package:reminder/view/screens/home_page.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context)=> HomePage(key: Key("key"),),
      },
    )
  );
}