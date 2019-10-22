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
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDebtPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: _appBody,
    );
  }
}
