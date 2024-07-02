import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ExpenseReportScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseReportScreen(),
    );
  }
}
