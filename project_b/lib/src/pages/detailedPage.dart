import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';

class DetailedPage extends StatefulWidget {
  final DebtBloc debtBloc;

  DetailedPage(this.debtBloc);

  @override
  State<StatefulWidget> createState() {
    return DetailedPageState();
  }
}

class DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    DebtListBloc _debtList = BlocProvider.of<DebtListBloc>(context);

    priorityFarbe() {
      if (widget.debtBloc.currentState.priority == 1) {
        return Text(
          "   High",
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      } else if (widget.debtBloc.currentState.priority == 2) {
        return Text(
          "   Normal",
          style: TextStyle(
            fontSize: 30,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        );
      } else if (widget.debtBloc.currentState.priority == 3) {
        return Text(
          "   Low",
          style: TextStyle(
            fontSize: 30,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      return Text(
        "   Keine",
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget debtNumber() {
      if (widget.debtBloc.currentState.iOwe) {
        return Text(
          "   -" + widget.debtBloc.currentState.debt.toString() + "€",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
          ),
        );
      } else if (!widget.debtBloc.currentState.iOwe) {
        return Text(
          "   +" + widget.debtBloc.currentState.debt.toString() + "€",
          style: TextStyle(
            color: Colors.green,
            fontSize: 30,
          ),
        );
      }
    }

    werSchuldetWem(){
      if(widget.debtBloc.currentState.iOwe == true){
        return Text("Ich schulde...",
          style: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        );
      }else if(widget.debtBloc.currentState.iOwe == false){
        return Text("Mir schuldet...",
          style: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        );
      }
      return Text("Nur arme leihen sich Geld...",
        style: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
      );
    }

    var _appBody = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
          ),
          child: Center(
            child: werSchuldetWem(),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "   " + widget.debtBloc.currentState.getName().toString(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Schulden",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
           debtNumber(),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Bis",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "   " +
                  widget.debtBloc.currentState
                      .getDebtDeadline()
                      .toString()
                      .substring(0, 10),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Erstellt",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "   " +
                  widget.debtBloc.currentState
                      .getDebtStart()
                      .toString()
                      .substring(0, 10),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "Priorität",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            priorityFarbe(),
          ],
        ),
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 30,
          color: Colors.black,
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            minWidth: 200.0,
            height: 35,
            color: Colors.black54,
            child: new Text(" Schuld wurde beglichen",
                style: new TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {
              _debtList.onRemoveDebt(widget.debtBloc);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
        ),
      ),
      body: _appBody,
    );
  }
}
