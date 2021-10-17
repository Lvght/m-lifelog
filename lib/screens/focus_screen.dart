import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        leading: const SizedBox(),
        title: Image.asset(
          'lib/res/compact_full_logo_white.png',
          height: 28,
        ),
        backgroundColor: const Color(0xFF191919),
        actions: [
          IconButton(
              onPressed: () {
                widget._saveCallback(
                    _titleController.text, _contentController.text);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_rounded,
                  color: Color(0xFFFEFEFE)))
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
                    hintText: AppLocalizations.of(context)!.title,
                    hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        color: const Color(0xFFFEFEFE).withOpacity(0.54))),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: const Color(0xFFFEFEFE)),
              ),
              const SizedBox(height: 16),
              TextField(
                autofocus: true,
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context)!.content,
                    hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: const Color(0xFFFEFEFE).withOpacity(0.54))),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: const Color(0xFFFEFEFE)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
