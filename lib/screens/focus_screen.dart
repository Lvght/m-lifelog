import 'package:flutter/material.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen(this._saveCallback, this._title, this._content, {Key? key})
      : super(key: key);
  final void Function(String?, String?) _saveCallback;
  final String _title;
  final String _content;

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget._title);
    _contentController = TextEditingController(text: widget._content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        leading: const SizedBox(),
        title: Image.asset(
          'lib/res/compact_full_logo_white.png',
          height: 28,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
              onPressed: () {
                widget._saveCallback(
                    _titleController.text, _contentController.text);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: InputDecoration.collapsed(
                    hintText: 'Título',
                    hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.54))),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(height: 16),
              TextField(
                autofocus: true,
                controller: _contentController,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Conteúdo'),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
