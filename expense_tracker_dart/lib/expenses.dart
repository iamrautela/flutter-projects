import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  // TODO: implement ==
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text('The Chart'), Text('Expense List...')]),
    );
  }
}
