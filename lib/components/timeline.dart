/*import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

import 'entry_card.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Widget? _builderDelegateFunction(BuildContext context, int index) {
    final _entry = Provider.of<MasterStore>(context).entries[index];
    return EntryCard(
      _entry,
      editFn: (Entry newEntry) {},
      deleteFn: (Entry e) async {
        final _store = Provider.of<MasterStore>(context, listen: false);

        _store.deleteEntry(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SliverList(
        delegate: SliverChildBuilderDelegate(
          _builderDelegateFunction,
          childCount:
              Provider.of<MasterStore>(context, listen: false).entries.length,
        ),
      ),
    );
  }
}
*/