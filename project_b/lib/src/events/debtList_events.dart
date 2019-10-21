import 'package:project_b/src/blocs/debt_bloc.dart';

abstract class DebtListEvents{}

class RemoveDebt extends DebtListEvents {
  DebtBloc debtBloc;
  RemoveDebt(this.debtBloc);
}

class RemoveAllDebts extends DebtListEvents{}

class AddDebt extends DebtListEvents {
  DebtBloc debtBloc;
  AddDebt(this.debtBloc);
}

