import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lifelog/components/entry_card.dart';
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
    return EntryCard(_entry);
  }

  Future<void>? _loadData() async {
    await Provider.of<MasterStore>(context, listen: false).getContent();
  }

  void _fobCallback() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Provider(
              builder: (_, __) => ComposeScreen(),
              create: (_) => Provider.of<MasterStore>(context, listen: false),
            )));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Lifelog'),
          ),
          Observer(
            builder: (_) => SliverList(
              delegate: SliverChildBuilderDelegate(
                _builderDelegateFunction,
                childCount: Provider.of<MasterStore>(context, listen: false)
                    .entries
                    .length,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _fobCallback,
        label: const Text('Nova entrada'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
