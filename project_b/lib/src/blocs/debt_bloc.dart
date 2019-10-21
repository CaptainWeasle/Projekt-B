import 'package:bloc/bloc.dart';
import 'package:project_b/src/events/debt_events.dart';
import 'package:project_b/src/models/debtItem.dart';

class DebtBloc extends Bloc<DebtEvents, DebtItem> {
  @override
  DebtItem get initialState => DebtItem.initial();

  @override
  Stream<DebtItem> mapEventToState(
    DebtEvents event,
  ) async* {
    
  }
}
