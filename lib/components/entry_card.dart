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
                  Text('09:41 AM - Hoje',
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.sentiment_very_satisfied_rounded),
              const SizedBox(width: 8),
              Text(
                'Bem',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
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
