import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  int? _currentReaction;

  void _setReaction(int i) {
    setState(() {
      _currentReaction = _currentReaction == i ? null : i;
    });
  }

  void _saveEntry(BuildContext context) {
    Provider.of<MasterStore>(context, listen: false).saveEntry(
        content: _contentController.text,
        title: _titleController.text,
        sentiment: _currentReaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova entrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Como você está se sentindo?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => _setReaction(1),
                    icon: Icon(Icons.sentiment_very_satisfied_rounded,
                        color: _currentReaction == 1
                            ? Theme.of(context).colorScheme.primary
                            : null)),
                IconButton(
                    onPressed: () => _setReaction(2),
                    icon: Icon(Icons.sentiment_satisfied_rounded,
                        color: _currentReaction == 2
                            ? Theme.of(context).colorScheme.primary
                            : null)),
                IconButton(
                    onPressed: () => _setReaction(3),
                    icon: Icon(Icons.sentiment_neutral_rounded,
                        color: _currentReaction == 3
                            ? Theme.of(context).colorScheme.primary
                            : null)),
                IconButton(
                    onPressed: () => _setReaction(4),
                    icon: Icon(Icons.sentiment_dissatisfied_rounded,
                        color: _currentReaction == 4
                            ? Theme.of(context).colorScheme.primary
                            : null)),
                IconButton(
                    onPressed: () => _setReaction(5),
                    icon: Icon(Icons.sentiment_very_dissatisfied_rounded,
                        color: _currentReaction == 5
                            ? Theme.of(context).colorScheme.primary
                            : null)),
              ],
            ),
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
                onPressed: () => _saveEntry(context),
                child: const Text('Salvar'))
          ],
        ),
      ),
    );
  }
}
