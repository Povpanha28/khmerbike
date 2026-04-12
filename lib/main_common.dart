import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Khmer Bike')),
        body: Center(child: Text('Welcome to Khmer Bike!')),
      ),
    );
  }
}
