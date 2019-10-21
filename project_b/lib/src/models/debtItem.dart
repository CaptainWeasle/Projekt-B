class DebtItem {
  String name;
  double debt;
  DateTime debtStartDate;
  DateTime debtDeadlineDate;

  DebtItem._();
  DebtItem({
    this.name,
    this.debt,
    this.debtStartDate,
    this.debtDeadlineDate,
  });

  String getName() => name;
  double getDebt() => debt;
  DateTime getDebtStart() => debtStartDate;
  DateTime getDebtDeadline() => debtDeadlineDate;

  String toString(){
    return "NAME: $name, DEBT: $debt, DEBT START: $debtStartDate, DEBT DEADLINE: $debtDeadlineDate";
  }

  factory DebtItem.initial(){
    return DebtItem._()
    ..debt = 0;
  }
}