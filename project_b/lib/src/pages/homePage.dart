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

    bool debtSwitch = false;

    double calcAllMyDebts() {
      double debt = 0;
      for (int i = 0; i < _debtListBloc.currentState.debtList.length; i++) {
        if (_debtListBloc.currentState.debtList[i].currentState.iOwe) {
          debt += _debtListBloc.currentState.debtList[i].currentState.getDebt();
        }
      }
      return debt;
    }

    double calcOtherDebts(){
      double debt = 0;
      for (int i = 0; i < _debtListBloc.currentState.debtList.length; i++) {
        if (!_debtListBloc.currentState.debtList[i].currentState.iOwe) {
          debt += _debtListBloc.currentState.debtList[i].currentState.getDebt();
        }
      }
      return debt;
    }

    double calcDebtDifference(){
      return calcOtherDebts() - calcAllMyDebts();
    }

    Widget summaryDialog = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text("Summary", style: TextStyle(color: Colors.black, fontSize: 25)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH SCHULDE INSGESAMT:"),
            Text(" " + calcAllMyDebts().toString() + "€"),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH BEKOMME INSGESAMT:"),
            Text(" " + calcOtherDebts().toString() + "€"),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("ALLGEMEINE BILANZ:"),
          Text(" " + calcDebtDifference().toString() + "€") 
        ]),
      ]),
    );

    Widget addDebtDialog = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Wer schuldet wem? ",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("ICH SCHULDE"),
                Switch(
                  value: debtSwitch,
                  onChanged: (value) {
                    setState(() {
                      debtSwitch = value;
                    });
                  },
                  activeTrackColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
                Text("MIR SCHULDET")
              ],
            ),
            TextField(
              controller: debtNameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: "Wer?/ Wem?"),
            ),
            TextField(
              controller: debtAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on), labelText: "Wie viel?"),
            ),
            DateTimeField(
              controller: debtDateController,
              format: DateFormat("yyyy-MM-dd"),
              decoration: InputDecoration(
                  icon: Icon(Icons.date_range), labelText: "Bis Wann?"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: MaterialButton(
                elevation: 5.0,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    DebtBloc newDebt = DebtBloc();
                    newDebt.currentState.name = debtNameController.text;
                    newDebt.currentState.debt =
                        double.parse(debtAmountController.text);
                    String date = debtDateController.text + " 00:00:00Z";
                    newDebt.currentState.debtDeadlineDate =
                        DateTime.parse(date);
                    newDebt.currentState.iOwe = !debtSwitch;
                    _debtListBloc.onAddDebt(newDebt);
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ],
        ),
      ),
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
    );

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
