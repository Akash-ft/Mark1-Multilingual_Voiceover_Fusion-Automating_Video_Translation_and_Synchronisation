import 'package:MVF/screens/home_screen/state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeSProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, HomeScreenState>(
        (ref) => HomeScreenController());

class HomeScreenController extends StateNotifier<HomeScreenState> {
  HomeScreenController() : super(HomeScreenState.empty());

  void switchTab(int tabIndex) {
    state = state.copyWith(tabIndex: tabIndex);
  }
}
