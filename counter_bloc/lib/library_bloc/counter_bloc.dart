import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  void onIncrement() {
    dispatch(IncrementEvent());
  }

  void onDecrement() {
    dispatch(DecrementEvent());
  }

  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(
      CounterState currentState, CounterEvent event) async* {
    final _currentState = currentState;
    if (event is IncrementEvent) {
      yield CounterState(counter: _currentState.counter + 1);
    } else if (event is DecrementEvent) {
      yield CounterState(counter: _currentState.counter - 1);
    }
  }
}
