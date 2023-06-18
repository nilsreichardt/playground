import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
class MyList extends _$MyList {
  bool _isInitialized = false;

  @override
  List<String> build() {
    final query = ref.watch(searchProvider);

    print('_isInitialized: $_isInitialized');
    final list = _isInitialized ? state : <String>[];

    if (!_isInitialized) {
      _isInitialized = true;
    }

    return list;
  }
}

@Riverpod(keepAlive: true)
class Search extends _$Search {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}
