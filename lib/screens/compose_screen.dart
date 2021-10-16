import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifelog/state/compose_store.dart';
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

  final _store = ComposeStore();

  void _saveEntry(BuildContext context) async {
    await Provider.of<MasterStore>(context, listen: false).saveEntry(
      content: _contentController.text,
      title: _titleController.text,
      sentiment: _store.currentSentiment,
      createdAt: _store.dateTime,
      image: _store.image,
    );

    Navigator.of(context).pop();
  }

  Future<void>? _invokeDateTimePicker(BuildContext context) async {
    DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    // Date picking was not cancelled. Now get the Hour/Minute.
    if (d != null) {
      TimeOfDay? t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      DateTime f = DateTime(d.year, d.month, d.day,
          t?.hour ?? DateTime.now().hour, t?.minute ?? DateTime.now().minute);

      _store.setDateTime(f);
    }
  }

  Future<void>? _getImage() async {
    final XFile? _file =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_file != null) {
      _store.setImage(await _file.readAsBytes());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova entrada'),
        actions: [
          IconButton(
            onPressed: () async => _saveEntry(context),
            icon: const Icon(Icons.check_circle_rounded),
          )
        ],
      ),
      body: Observer(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 128),
            child: Column(
              children: [
                Text(
                  'Como você está se sentindo?',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => _store.setCurrentSentiment(1),
                        icon: Icon(Icons.sentiment_very_satisfied_rounded,
                            color: _store.currentSentiment == 1
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    IconButton(
                        onPressed: () => _store.setCurrentSentiment(2),
                        icon: Icon(Icons.sentiment_satisfied_rounded,
                            color: _store.currentSentiment == 2
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    IconButton(
                        onPressed: () => _store.setCurrentSentiment(3),
                        icon: Icon(Icons.sentiment_neutral_rounded,
                            color: _store.currentSentiment == 3
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    IconButton(
                        onPressed: () => _store.setCurrentSentiment(4),
                        icon: Icon(Icons.sentiment_dissatisfied_rounded,
                            color: _store.currentSentiment == 4
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    IconButton(
                        onPressed: () => _store.setCurrentSentiment(5),
                        icon: Icon(Icons.sentiment_very_dissatisfied_rounded,
                            color: _store.currentSentiment == 5
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                  ],
                ),
                const SizedBox(height: 64),
                if (_store.image != null)
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          child: Image.memory(
                            _store.image!,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: IconButton(
                          icon: const Icon(Icons.remove_circle_rounded),
                          onPressed: () {
                            _store.setImage(null);
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Título',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Conteúdo',
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      // Avoid bottom sheet to be above keyboard.
      resizeToAvoidBottomInset: false,
      bottomSheet: Observer(builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton.icon(
                  onPressed: () async => _invokeDateTimePicker(context),
                  onLongPress: () => _store.setDateTime(null),
                  icon: const Icon(Icons.access_time_filled_rounded),
                  label: Text(_store.dateTime == null
                      ? 'Agora'
                      : '${_store.dateTime!.day.toString().padLeft(2, '0')}/'
                          '${_store.dateTime!.month.toString().padLeft(2, '0')}/'
                          '${_store.dateTime!.year} '
                          '| ${_store.dateTime!.hour.toString().padLeft(2, '0')}'
                          ':${_store.dateTime!.minute.toString().padLeft(2, '0')}')),
              IconButton(
                onPressed: () async => await _getImage(),
                icon: Icon(Icons.add_photo_alternate_rounded,
                    color: _store.image == null
                        ? null
                        : Theme.of(context).colorScheme.primary),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tag_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_location_alt_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add_rounded),
              ),
            ],
          ),
        );
      }),
    );
  }
}
