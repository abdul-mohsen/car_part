import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HomePageState {
  final int count;
  final bool isMinusEnabled;
  final bool isPlusEnabled;

  HomePageState({
    this.isMinusEnabled = false,
    this.isPlusEnabled = true,
    this.count = 0,
  });

  HomePageState copyWith({
    bool? isMinusEnabled,
    bool? isPlusEnabled,
    int? count,
  }) {
    return HomePageState(
      isMinusEnabled: isMinusEnabled ?? this.isMinusEnabled,
      isPlusEnabled: isPlusEnabled ?? this.isPlusEnabled,
      count: count ?? this.count,
    );
  }
}

class HomePageViewModel extends ViewModel {
  final _stateSubject = BehaviorSubject<HomePageState>.seeded(HomePageState());
  Stream<HomePageState> get state => _stateSubject;

  final client = Modular.get<CarPartRepository>();

  void plusButtonTapped() {
    client.getCarPartAutoCompletelist("26300-02503").listen((event) {
      debug("ssda $event");
    });
    _updateState(_stateSubject.value.count + 1);
  }

  void minusButtonTapped() {
    _updateState(_stateSubject.value.count - 1);
  }

  void secondPageButtonTapped() {
    addToNavigation(
      AppRouteSpec(
        name: '/second',
        arguments: {
          'count': _stateSubject.value.count,
        },
      ),
    );
  }

  void _updateState(int newCount) {
    final state = _stateSubject.value;
    // _stateSubject.add(
    //   state.copyWith(
    //     count: newCount,
    //     isPlusEnabled: newCount < 5,
    //     isMinusEnabled: newCount > 0,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _stateSubject.close();
  }
}
