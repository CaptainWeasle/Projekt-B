import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/models/debtList.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:project_b/src/ui_elements/debtItemWidget.dart';

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

    bool debtSwitch = false;

    Widget summaryDialog = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text("Summary", style: TextStyle(color: Colors.black, fontSize: 25)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH SCHULDE INSGESAMT:"),
            Text("insert VAR here")
            //TODO hier funktionalität und so blah blah
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH BEKOMME INSGESAMT:"),
            Text("inservt VAR here") //TODO hier funktionalität blah blah
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("ALLGEMEINE BILANZ:"),
          Text("inservt VAR here") //TODO hier funktionalität blah blah
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
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: "Wer?/ Wem?"),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on), labelText: "Wie viel?"),
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  icon: Icon(Icons.access_time), labelText: "Bis Wann?"),
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
                    Navigator.pop(context);
                  }),
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
                    Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                child: Opacity(
                    opacity: a1.value,
                    child: CustomAlert(
                      content: summaryDialog,
                    )),
              );
            },
            transitionDuration: Duration(milliseconds: 150),
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
