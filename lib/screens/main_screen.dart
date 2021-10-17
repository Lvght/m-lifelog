import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lifelog/components/entry_card.dart';
import 'package:lifelog/models/entry.dart';
import 'package:lifelog/screens/compose_screen.dart';
import 'package:lifelog/state/master_store.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? _builderDelegateFunction(BuildContext context, int index) {
    final _entry = Provider.of<MasterStore>(context).entries[index];
    return EntryCard(
      _entry,
      editFn: (Entry e) async {
        final _store = Provider.of<MasterStore>(context, listen: false);
        _store.editEntry(e, index: index);
      },
      deleteFn: (Entry e) async {
        final _store = Provider.of<MasterStore>(context, listen: false);
        _store.deleteEntry(index);
      },
    );
  }

  Future<void>? _loadData() async {
    await Provider.of<MasterStore>(context, listen: false).getContent();
  }

  void _fobCallback() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Provider(
          builder: (_, __) => ComposeScreen(
            saveEntryCallback: (Entry e) async {
              Provider.of<MasterStore>(context, listen: false).saveEntry(e);
              Navigator.of(context).pop();
            },
          ),
          create: (_) => Provider.of<MasterStore>(context, listen: false),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadData();
    });
  }

  bool _locked = false;

  Future<void>? _fetchMoreContent() async {
    if (!_locked) {
      _locked = true;
      await Provider.of<MasterStore>(context, listen: false).getContent();
      _locked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Load more content when user aproaches bottom of screen.
          if (notification.metrics.maxScrollExtent -
                  notification.metrics.pixels <
              10) {
            _fetchMoreContent();
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: SizedBox(
                  height: 32,
                  child: Image.asset('lib/res/compact_full_logo_white.png')),
            ),
            Observer(
              builder: (_) {
                if (Provider.of<MasterStore>(context, listen: false)
                    .entries
                    .isEmpty) {
                  return SliverFillRemaining(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
                      child: const Text(
                          '😔 Parece que não há nada aqui... ainda.'),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _builderDelegateFunction,
                    childCount: Provider.of<MasterStore>(context, listen: false)
                        .entries
                        .length,
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 128)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _fobCallback,
        label: const Text('Nova entrada'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
