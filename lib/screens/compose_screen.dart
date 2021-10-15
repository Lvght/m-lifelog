import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class ComposeScreen extends StatelessWidget {
  ComposeScreen({Key? key}) : super(key: key);

  final _controller = TextEditingController();

  void _saveEntry(BuildContext context) {
    Entry e = Entry(content: _controller.text);
    Provider.of<MasterStore>(context, listen: false).saveEntry(e);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova entrada'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          ElevatedButton(
              onPressed: () => _saveEntry(context), child: const Text('Salvar'))
        ],
      ),
    );
  }
}
