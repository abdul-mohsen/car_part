import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:rxdart/rxdart.dart';

class SecondPageState {
  final int count;

  SecondPageState({
    this.count = 0,
  });

  SecondPageState copyWith({
    int? count,
  }) {
    return SecondPageState(
      count: count ?? this.count,
    );
  }
}

class SecondPageViewModel extends ViewModel {
  final _stateSubject =
      BehaviorSubject<SecondPageState>.seeded(SecondPageState());
  Stream<SecondPageState> get state => _stateSubject;

  SecondPageViewModel({required int count}) {
    _stateSubject.add(SecondPageState(count: count));
  }

  void thirdPageButtonTapped() {
    addToNavigation(
      const AppRouteSpec(name: '/third'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stateSubject.close();
  }
}
