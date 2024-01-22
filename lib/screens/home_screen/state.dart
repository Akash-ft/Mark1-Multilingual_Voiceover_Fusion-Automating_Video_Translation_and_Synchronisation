class HomeScreenState {
  final int? tabIndex;

  HomeScreenState({
    this.tabIndex,
  });

  factory HomeScreenState.empty() {
    return HomeScreenState(
      tabIndex: 0,
    );
  }

  HomeScreenState copyWith({
    final int? tabIndex,
  }) {
    return HomeScreenState(
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}
