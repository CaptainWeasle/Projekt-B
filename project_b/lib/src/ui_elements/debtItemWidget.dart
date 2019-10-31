import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';
import 'package:project_b/src/pages/detailedPage.dart';

class DebtItemWidget extends StatefulWidget {
  final DebtBloc debtBloc;

  const DebtItemWidget({Key key, this.debtBloc}) : super(key: key);

  State<StatefulWidget> createState() => DebtItemWidgetState();
}

class DebtItemWidgetState extends State<DebtItemWidget> {
  @override
  Widget build(BuildContext context) {
    priorityFarbe() {
      if (widget.debtBloc.currentState.priority == 1) {
        return Text(
          " High",
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        );
      } else if (widget.debtBloc.currentState.priority == 2) {
        return Text(
          "Normal",
          style: TextStyle(
            fontSize: 20,
            color: Colors.orange,
          ),
        );
      } else if (widget.debtBloc.currentState.priority == 3) {
        return Text(
          " Low",
          style: TextStyle(
            fontSize: 20,
            color: Colors.green,
          ),
        );
      }
      return Text(
        "Keine",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      );
    }

    debtBoxFarbe() {
      if (widget.debtBloc.currentState.iOwe) {
        return Colors.red;
      } else if (!widget.debtBloc.currentState.iOwe) {
        return Colors.green;
      }
      return Colors.grey;
    }

    var _appBody = Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: debtBoxFarbe(),
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.account_box,
                  size: 60,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.debtBloc.currentState.getName().toString() + ":",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "  Bis: " +
                      widget.debtBloc.currentState
                          .getDebtDeadline()
                          .toString()
                          .substring(0, 10) +
                      "    ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.debtBloc.currentState.debt.toString() + " €",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                          color: debtBoxFarbe(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Priority: ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    priorityFarbe(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedPage(widget.debtBloc),
          ),
        );
      },
      child: _appBody,
    );
  }
}
