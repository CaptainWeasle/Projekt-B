import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';

class AddDebtPage extends StatefulWidget {
  final DebtListBloc debtListBloc;

  const AddDebtPage({Key key, this.debtListBloc,}) : super(key: key);

  State<AddDebtPage> createState() => AddDebtPageState();
}



class AddDebtPageState extends State<AddDebtPage> {

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

  Widget build(BuildContext context) {


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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
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
                      widget.debtListBloc.onAddDebt(newDebt);
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


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: addDebtDialog,
    );
  }
}
