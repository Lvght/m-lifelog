import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';

enum EntryCardMenuActions { delete, star }

class EntryCard extends StatelessWidget {
  const EntryCard(this._entry, {required this.deleteFn, Key? key})
      : super(key: key);
  final Entry _entry;
  final Future<void>? Function(Entry) deleteFn;

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
    int daysDifference = _entry.createdAt.difference(DateTime.now()).inDays;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
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
                onSelected: (EntryCardMenuActions action) async {
                  switch (action) {
                    case EntryCardMenuActions.delete:
                      await deleteFn(_entry);
                      break;
                    case EntryCardMenuActions.star:
                      // TODO: Handle this case.
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<EntryCardMenuActions>>[
                  PopupMenuItem(
                    child: Row(
                      children: const [
                        Icon(Icons.star_rounded),
                        SizedBox(width: 8),
                        Text('Favoritar'),
                      ],
                    ),
                    value: EntryCardMenuActions.star,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: const [
                        Icon(Icons.delete_rounded),
                        SizedBox(width: 8),
                        Text('Apagar'),
                      ],
                    ),
                    value: EntryCardMenuActions.delete,
                  ),
                ],
              )
            ],
          ),
          if (_entry.sentiment != null) _getSentimentIndicator(context),
          const SizedBox(height: 16),
          if (_entry.title != null)
            Text(_entry.title!, style: Theme.of(context).textTheme.headline6),
          if (_entry.content != null)
            Text(_entry.content!, style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 32),
          Divider(
            endIndent: MediaQuery.of(context).size.width * 0.8,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
