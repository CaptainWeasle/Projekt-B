import 'package:bloc/bloc.dart';
import 'package:project_b/src/events/debtList_events.dart';
import 'package:project_b/src/models/debtList.dart';

import 'debt_bloc.dart';

class DebtListBloc extends Bloc<DebtListEvents, DebtList> {

  onRemoveCard(DebtBloc item) {
    dispatch(RemoveDebt(item));
  }

  onAddCard(DebtBloc item) {
    dispatch(AddDebt(item));
  }

  onRemoveAllCards(){
    dispatch(RemoveAllDebts());
  }

  @override
  DebtList get initialState => DebtList.initial();

  @override
  Stream<DebtList> mapEventToState(
    DebtListEvents event,
  ) async* {
    if(event is RemoveDebt){
      currentState.debtList.remove(event.debtBloc);
      yield DebtList(debtList: currentState.debtList);
    }else if(event is AddDebt){
      currentState.debtList.add(event.debtBloc);
      yield DebtList(debtList: currentState.debtList);
    }else if(event is RemoveAllDebts){
      yield DebtList(debtList: []);
    }
  }
}
