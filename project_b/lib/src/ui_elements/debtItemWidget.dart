import 'package:flutter/widgets.dart';
import 'package:project_b/src/blocs/debt_bloc.dart';

class DebtItemWidget extends StatefulWidget {
  final DebtBloc debtBloc;

  const DebtItemWidget({Key key, this.debtBloc}) : super(key: key);

  
  State<StatefulWidget> createState() => DebtItemWidgetState();
}

class DebtItemWidgetState extends State<DebtItemWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "DetailedPage");
      },
      child: Text(widget.debtBloc.currentState.toString()),
    );
  }
}
