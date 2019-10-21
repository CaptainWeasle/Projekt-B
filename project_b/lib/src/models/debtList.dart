import 'package:project_b/src/blocs/debt_bloc.dart';

class DebtList{
  List<DebtBloc> debtList;
  int count;

  DebtList._();
  DebtList({
    this.debtList,
  });

  int getCount() => count;

  String toString() => "NUMBER OF DEBTS: $count, DEBTS: $debtList,";

  factory DebtList.initial(){
    return DebtList._()
    ..debtList = []
    ..count = 0;
  }
}