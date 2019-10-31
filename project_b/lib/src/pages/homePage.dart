import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';
import 'package:project_b/src/models/debtList.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:project_b/src/ui_elements/debtItemWidget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DebtListBloc _debtListBloc = BlocProvider.of<DebtListBloc>(context);

    TextEditingController debtNameController = TextEditingController();
    TextEditingController debtAmountController = TextEditingController();
    TextEditingController debtDateController = TextEditingController();
    var prio = 0;

    IconData _iconPrio = Icons.add_circle_outline;

    bool debtSwitch = false;

    var bilanzColor;

    double calcAllMyDebts() {
      double debt = 0;
      for (int i = 0; i < _debtListBloc.currentState.debtList.length; i++) {
        if (_debtListBloc.currentState.debtList[i].currentState.iOwe) {
          debt += _debtListBloc.currentState.debtList[i].currentState.getDebt();
        }
      }
      return debt;
    }

    double calcOtherDebts() {
      double debt = 0;
      for (int i = 0; i < _debtListBloc.currentState.debtList.length; i++) {
        if (!_debtListBloc.currentState.debtList[i].currentState.iOwe) {
          debt += _debtListBloc.currentState.debtList[i].currentState.getDebt();
        }
      }
      return debt;
    }

    double calcDebtDifference() {
      var calcDiff = calcOtherDebts() - calcAllMyDebts();
      if (calcDiff > 0) {
        bilanzColor = Colors.green;
      } else if (calcDiff < 0) {
        bilanzColor = Colors.red;
      } else {
        bilanzColor = Colors.black;
      }
      return calcDiff;
    }

    Widget summaryDialog = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 75,
          width: 370,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Summary",
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "ICH SCHULDE GESAMT:",
                  style: TextStyle(
                      height: 2.5, fontSize: 20, fontFamily: 'Montserrat'),
                ),
                Text(
                  " -" + calcAllMyDebts().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "ICH BEKOMME GESAMT:",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  " " + calcOtherDebts().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Meine Bilanz:",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  " " + calcDebtDifference().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: bilanzColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    Widget addDebtDialog = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 75,
          width: 370,
          child: Center(
            child: Text(
              "Schuld hinzufügen",
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Ich schulde",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Switch(
                    value: debtSwitch,
                    onChanged: (value) {
                      setState(
                        () {
                          debtSwitch = value;
                        },
                      );
                    },
                    activeTrackColor: Theme.of(context).accentColor,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Mir schuldet",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: TextField(
                maxLength: 9,
                controller: debtNameController,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.account_circle),
                    labelText: "Wer?/ Wem?"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: TextField(
                maxLength: 4,
                controller: debtAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.monetization_on),
                    labelText: "Wie viel?"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: DateTimeField(
                controller: debtDateController,
                format: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.date_range),
                    labelText: "Bis Wann?"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                "Priorität?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(_iconPrio),
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    setState(
                      () {
                        prio = 1;
                        _iconPrio = Icons.add_circle;
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_iconPrio),
                  iconSize: 30,
                  color: Colors.orange,
                  onPressed: () {
                    setState(
                      () {
                        prio = 2;
                        _iconPrio = Icons.add_circle;
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_iconPrio),
                  iconSize: 30,
                  color: Colors.green,
                  onPressed: () {
                    setState(
                      () {
                        prio = 3;
                        _iconPrio = Icons.add_circle;
                      },
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 25,
                colorBrightness: Brightness.dark,
                child: Text(
                  "Bestätigen",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                color: Colors.black,
                onPressed: () {
                  setState(
                    () {
                      DebtBloc newDebt = DebtBloc();
                      newDebt.currentState.name = debtNameController.text;
                      newDebt.currentState.debt =
                          double.parse(debtAmountController.text);
                      String date = debtDateController.text + " 00:00:00Z";
                      newDebt.currentState.debtDeadlineDate =
                          DateTime.parse(date);
                      newDebt.currentState.iOwe = !debtSwitch;
                      newDebt.currentState.priority = prio;
                      _debtListBloc.onAddDebt(newDebt);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );

    var _summaryIcon = IconButton(
      icon: Icon(Icons.assessment),
      onPressed: () {
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.01),
            transitionBuilder: (context, a1, a2, widget) {
              final curvedValue =
                  Curves.linearToEaseOut.transform(a1.value) - 1.0;
              return Transform(
                transform:
                    Matrix4.translationValues(0.0, curvedValue * 600, 0.0),
                child: Opacity(
                    opacity: a1.value,
                    child: CustomAlert(
                      content: summaryDialog,
                    )),
              );
            },
            transitionDuration: Duration(milliseconds: 350),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      },
    );

    var _floatingActionButton = FloatingActionButton(
        onPressed: () {
          //TODO: Opacity transition, also rein faden und raus faden
          showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.2),
            transitionBuilder: (context, a1, a2, widget) {
              return CustomAlert(
                content: addDebtDialog,
              );
            },
            pageBuilder: (context, animation1, animation2) {},
            transitionDuration: Duration(milliseconds: 0),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black);

    var _appBody = BlocBuilder(
      bloc: _debtListBloc,
      builder: (context, DebtList state) {
        return ListView.builder(
          itemCount: _debtListBloc.currentState.debtList.length,
          itemBuilder: (BuildContext context, int i) {
            return DebtItemWidget(
              debtBloc: state.debtList[i],
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Debt Collector 3000"),
        actions: <Widget>[
          _summaryIcon,
        ],
      ),
      floatingActionButton: _floatingActionButton,
      body: _appBody,
    );
  }
}
