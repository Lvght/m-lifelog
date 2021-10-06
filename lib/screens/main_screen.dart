import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Widget? _builderDelegateFunction(BuildContext context, int index) {
    return Text('Index $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Lifelog'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _builderDelegateFunction,
              childCount: 10,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Nova entrada'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
