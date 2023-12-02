import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeSProvider = Provider((ref) => HomeScreenController());

class HomeScreenController {
  final bottomNavIndexProvider = StateProvider((ref) => 0);
}
