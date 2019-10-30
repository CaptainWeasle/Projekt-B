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
    var _appBody = Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        color: Colors.black45,
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
                color: Colors.red,
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.attach_money,
                  size: 50,
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
                Text(widget.debtBloc.currentState.getDebtDeadline().toString().substring(0, 10),
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
                        widget.debtBloc.currentState.debt.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.debtBloc.currentState.getPriority().toString(),
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
