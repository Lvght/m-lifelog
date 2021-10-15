import 'package:flutter/material.dart';
import 'package:lifelog/models/entry.dart';

class EntryCard extends StatelessWidget {
  const EntryCard(this._entry, {Key? key}) : super(key: key);
  final Entry _entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.access_time_filled),
            const Text('09:41 AM - Hoje'),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_outline_rounded),
                ]))
          ]),
          const SizedBox(height: 16),
          if (_entry.title != null)
            Text(_entry.title!, style: Theme.of(context).textTheme.headline4),
          if (_entry.content != null)
            Text(_entry.content!, style: Theme.of(context).textTheme.bodyText1),
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
