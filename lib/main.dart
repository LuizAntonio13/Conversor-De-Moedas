import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'com.microsoft.appcenter.AppCenter';
//import 'com.microsoft.appcenter.analytics.Analytics';
//import 'com.microsoft.appcenter.crashes.Crashes';
import 'paginaprincipal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: PaginaPrincipal(),
      debugShowCheckedModeBanner: false,
   );
  } 
}