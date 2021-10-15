import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class ComposeScreen extends StatelessWidget {
  ComposeScreen({Key? key}) : super(key: key);

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveEntry(BuildContext context) {
    Provider.of<MasterStore>(context, listen: false).saveEntry(
        content: _contentController.text, title: _titleController.text);
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
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Título',
            ),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
              hintText: 'Conteúdo',
            ),
          ),
          ElevatedButton(
              onPressed: () => _saveEntry(context), child: const Text('Salvar'))
        ],
      ),
    );
  }
}
