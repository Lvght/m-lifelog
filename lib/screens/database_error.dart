import 'package:flutter/material.dart';

class DatabaseErrorScreen extends StatelessWidget {
  const DatabaseErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Algo deu errado.')),
        body: const Text(':('));
  }
}
