class DebtItem {
  String name;
  double debt;
  DateTime debtStartDate;
  DateTime debtDeadlineDate;
  int priority;
  bool iOwe;

  DebtItem._();
  DebtItem({
    this.name,
    this.debt,
    this.debtStartDate,
    this.debtDeadlineDate,
    this.priority,
    this.iOwe,
  });

  String getName() => name;
  double getDebt() => debt;
  DateTime getDebtStart() => debtStartDate;
  DateTime getDebtDeadline() => debtDeadlineDate;
  int getPriority(){
    return priority;
  }

  String toString(){
    return "NAME: $name, DEBT: $debt, DO I OWE? $iOwe, DEBT START: $debtStartDate, DEBT DEADLINE: $debtDeadlineDate, PRIORITY: $priority";
  }

  factory DebtItem.initial(){
    return DebtItem._()
    ..debt = 0
    ..debtStartDate = DateTime.now();
  }
}