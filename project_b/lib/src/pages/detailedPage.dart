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

    Widget debtNumber() {
      if (widget.debtBloc.currentState.iOwe) {
        return Text(
          "-" + widget.debtBloc.currentState.debt.toString() + "€",
          style: TextStyle(color: Colors.red),
        );
      } else if (!widget.debtBloc.currentState.iOwe) {
        return Text(
          "+" + widget.debtBloc.currentState.debt.toString() + "€",
          style: TextStyle(color: Colors.green),
        );
      }
    }

    var _appBody = Column(
      children: <Widget>[
        debtNumber(),
        MaterialButton(
          child: Text("Schuld begleichen"),
          onPressed: () {
            setState(
              () {
                _debtList.onRemoveDebt(widget.debtBloc);
                Navigator.pop(context);
              },
            );
          },
        ),
        Text(
          widget.debtBloc.currentState.toString(),
        ),
      ],
    );

    return Scaffold(appBar: AppBar(title: Text("Details")), body: _appBody);
  }
}
