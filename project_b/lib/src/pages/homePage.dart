import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/models/debtList.dart';
import 'package:project_b/src/pages/addDebtPage.dart';
import 'package:project_b/src/ui_elements/debtItemWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  createAlertDialog(BuildContext context) {
    TextEditingController debtInputController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //this right here

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: "Wer?/ Wem?"),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_balance),
                        labelText: "Wie viel?"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: MaterialButton(
                        elevation: 5.0,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        color: Colors.yellow,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DebtListBloc _debtListBloc = BlocProvider.of<DebtListBloc>(context);

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAlertDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: _appBody,
    );
  }
}
