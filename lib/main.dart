import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() => runApp(const SavedPlacesApp());

class SavedPlacesApp extends StatefulWidget {
  const SavedPlacesApp({super.key});

  @override
  State<SavedPlacesApp> createState() => _SavedPlacesAppState();
}

class _SavedPlacesAppState extends State<SavedPlacesApp> {
  late final SemanticsHandle _semanticsHandle;

  @override
  void initState() {
    super.initState();
    _semanticsHandle = SemanticsBinding.instance.ensureSemantics();
  }

  @override
  void dispose() {
    _semanticsHandle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Saved Places Lab',
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const SavedPlacesScreen(),
  );
}

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  static const _places = ['Park', 'Museum', 'Cafe'];
  final _saved = <String>{'Museum'};
  bool _savedOnly = false;

  List<String> get _visiblePlaces =>
      _savedOnly ? _places.where(_saved.contains).toList() : _places;

  @override
  Widget build(BuildContext context) {
    final visible = _visiblePlaces;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Places')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Choose places for your next trip.'),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                children: [
                  ChoiceChip(
                    key: const ValueKey('all-filter'),
                    label: const Text('All'),
                    selected: !_savedOnly,
                    onSelected: (_) => setState(() => _savedOnly = false),
                  ),
                  ChoiceChip(
                    key: const ValueKey('saved-filter'),
                    label: const Text('Saved'),
                    selected: _savedOnly,
                    onSelected: (_) => setState(() => _savedOnly = true),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Showing ${visible.length} places',
                key: const ValueKey('visible-count'),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: visible.isEmpty
                    ? const Center(child: Text('No saved places'))
                    : ListView(
                        children: [
                          for (final place in visible)
                            Card(
                              child: ListTile(
                                key: ValueKey('place-$place'),
                                title: Text(place),
                                subtitle: Text(
                                  _saved.contains(place)
                                      ? 'Saved for later'
                                      : 'Not saved',
                                ),
                                trailing: IconButton(
                                  key: ValueKey('toggle-$place'),
                                  tooltip: _saved.contains(place)
                                      ? 'Unsave $place'
                                      : 'Save $place',
                                  icon: Icon(
                                    _saved.contains(place)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                  ),
                                  onPressed: () => setState(() {
                                    if (!_saved.add(place)) {
                                      _saved.remove(place);
                                    }
                                  }),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
