import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/screens/compose_screen.dart';

enum EntryCardMenuActions { delete, edit, star }

class EntryCard extends StatelessWidget {
  const EntryCard(this._entry,
      {required this.deleteFn, required this.editFn, Key? key})
      : super(key: key);
  final Entry _entry;
  final Future<void>? Function(Entry) deleteFn;
  final Future<void>? Function(Entry) editFn;

  String _weekday(int v) {
    switch (v) {
      case DateTime.sunday:
        return 'Domingo';
      case DateTime.monday:
        return 'Segunda-feira';
      case DateTime.tuesday:
        return 'Terça-feira';
      case DateTime.wednesday:
        return 'Quarta-feira';
      case DateTime.thursday:
        return 'Quinta-feira';
      case DateTime.friday:
        return 'Sexta-feira';
      default:
        return 'Sábado';
    }
  }

  /// Returns the Entry Card timestamp indicator.
  String _entryTimestampIndicator() {
    DateTime now = DateTime.now();

    // Entry may be from yesterday, but has been written in less than 24hrs ago.
    now = DateTime(now.year, now.month, now.day);
    DateTime createdDate = DateTime(
        _entry.createdAt.year, _entry.createdAt.month, _entry.createdAt.day);

    int daysDifference = now.difference(createdDate).inDays;

    /// Shows 'Today', 'Yesterday' or the entry date in dd/mm/yyyy.
    String weekdayIndicator = '';
    if (daysDifference == 0) {
      weekdayIndicator = 'Hoje';
    } else if (daysDifference == 1) {
      weekdayIndicator = 'Ontem';
    } else {
      weekdayIndicator = '${_entry.createdAt.day.toString().padLeft(2, '0')}/'
          '${_entry.createdAt.month.toString().padLeft(2, '0')}/'
          '${_entry.createdAt.year}';
    }

    // hh:mm - [Today|dd/mm/yyyy], Weekday
    return '${_entry.createdAt.hour.toString().padLeft(2, '0')}:'
        '${_entry.createdAt.minute.toString().padLeft(2, '0')} - $weekdayIndicator, ${_weekday(_entry.createdAt.weekday)}';
  }

  /// Returns the icon and text combination expressing the entries sentiment.
  Widget _getSentimentIndicator(BuildContext context) {
    Icon? icon;
    String? text;

    switch (_entry.sentiment) {
      case 1:
        icon = const Icon(Icons.sentiment_very_satisfied_rounded);
        text = 'Excelente';
        break;
      case 2:
        icon = const Icon(Icons.sentiment_satisfied_rounded);
        text = 'Bem';
        break;
      case 3:
        icon = const Icon(Icons.sentiment_neutral_rounded);
        text = 'Normal';
        break;
      case 4:
        icon = const Icon(Icons.sentiment_dissatisfied_rounded);
        text = 'Mal';
        break;
      case 5:
        icon = const Icon(Icons.sentiment_very_dissatisfied_rounded);
        text = 'Péssimo';
        break;
      default:
        return const SizedBox();
    }

    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }

  void _editEntryCallback(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ComposeScreen(
              initialEntry: _entry,
              saveEntryCallback: (Entry e) async {
                editFn(e);
                Navigator.of(context).pop();
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time_filled),
                  const SizedBox(width: 8),
                  Text(_entryTimestampIndicator(),
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              PopupMenuButton<EntryCardMenuActions>(
                color: Theme.of(context).colorScheme.secondary,
                onSelected: (EntryCardMenuActions action) async {
                  switch (action) {
                    case EntryCardMenuActions.delete:
                      await deleteFn(_entry);
                      break;
                    case EntryCardMenuActions.edit:
                      _editEntryCallback(context);
                      break;
                    case EntryCardMenuActions.star:
                      // TODO: Handle this case.
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<EntryCardMenuActions>>[
                  /*PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Theme.of(context).colorScheme.onSecondary),
                        const SizedBox(width: 8),
                        const Text('Favoritar'),
                      ],
                    ),
                    value: EntryCardMenuActions.star,
                  ),*/
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.edit_rounded,
                            color: Theme.of(context).colorScheme.onSecondary),
                        const SizedBox(width: 8),
                        const Text('Editar'),
                      ],
                    ),
                    value: EntryCardMenuActions.edit,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.onSecondary),
                        const SizedBox(width: 8),
                        const Text('Apagar'),
                      ],
                    ),
                    value: EntryCardMenuActions.delete,
                  ),
                ],
              )
            ],
          ),
          if (_entry.sentiment != null) _getSentimentIndicator(context),

          // Attached image.
          if (_entry.image != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  child: Image.memory(
                    _entry.image!,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          if (_entry.title != null)
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(_entry.title!,
                  style: Theme.of(context).textTheme.headline6),
            ),
          if (_entry.content != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(_entry.content!,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          Divider(
            endIndent: MediaQuery.of(context).size.width * 0.8,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
