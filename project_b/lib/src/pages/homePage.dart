import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';
import 'package:project_b/src/models/debtList.dart';
import 'package:project_b/src/pages/addDebtPage.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:project_b/src/ui_elements/dataSearch.dart';
import 'package:project_b/src/ui_elements/debtItemWidget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var prio = 0;

  IconData _iconPrio1 = Icons.add_circle_outline;
  IconData _iconPrio2 = Icons.add_circle_outline;
  IconData _iconPrio3 = Icons.add_circle_outline;

  getRightIcon(){
    if(prio == 1){
      _iconPrio1 = Icons.add_circle;
      _iconPrio2 = Icons.add_circle_outline;
      _iconPrio3 = Icons.add_circle_outline;
    }else if(prio == 2){
      _iconPrio2 = Icons.add_circle;
      _iconPrio1 = Icons.add_circle_outline;
      _iconPrio3 = Icons.add_circle_outline;
    }else if(prio == 3){
      _iconPrio3 = Icons.add_circle;
      _iconPrio2 = Icons.add_circle_outline;
      _iconPrio1 = Icons.add_circle_outline;
    }
  }

  bool debtSwitch = false;

  TextEditingController debtNameController = TextEditingController();
  TextEditingController debtAmountController = TextEditingController();
  TextEditingController debtDateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    DebtListBloc _debtListBloc = BlocProvider.of<DebtListBloc>(context);

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

    Widget addDebtDialog = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
            
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
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
                  labelText: "Wer?/ Wem?",
                ),
                onChanged: (s) {
                  print( debtNameController.text);
                },
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
                  icon: Icon(_iconPrio1),
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    setState(
                          () {
                        prio = 1;
                        getRightIcon();
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_iconPrio2),
                  iconSize: 30,
                  color: Colors.orange,
                  onPressed: () {
                    setState(
                          () {
                        prio = 2;
                        getRightIcon();
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_iconPrio3),
                  iconSize: 30,
                  color: Colors.green,
                  onPressed: () {
                    setState(
                          () {
                        prio = 3;
                        getRightIcon();
                      },
                    );
                  },
                ),
              ],
            ),
            Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),),
          ),
          height: 50,
          width: 370,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: (){
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
                child: Center(
                  child: Text(
                    "Bestätigen",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
          ],
        ),
      ],
    );


    Widget summaryDialog = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),),
          ),
          height: 60,
          width: 370,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
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

    var _summaryIcon = IconButton(
      icon: Icon(Icons.assessment),
      onPressed: () {
        setState(() {
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
        });
      },
    );

    var _searchIcon = IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
            context: context,
            delegate: DataSearch(
              bloc: _debtListBloc,
            ));
      },
    );

    var _floatingActionButton = FloatingActionButton(
        onPressed: () {
          setState(() {
            showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.2),
              transitionBuilder: (context, a1, a2, widget) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: addDebtDialog,
                );
              },
              pageBuilder: (context, animation1, animation2) {},
              transitionDuration: Duration(milliseconds: 0),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
            );
          });
          //TODO: Opacity transition, also rein faden und raus faden

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
          _searchIcon,
          _summaryIcon,
        ],
      ),
      floatingActionButton: _floatingActionButton,
      body: _appBody,
    );
  }
}
