import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_b/src/blocs/debtList_bloc.dart';
import 'package:project_b/src/pages/detailedPage.dart';
import 'package:project_b/src/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DebtListBloc>(
          builder: (BuildContext context) => DebtListBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.black54,

          // Define the default font family.
          fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        initialRoute: "HomePage",
        routes: {
          "HomePage": (context) => HomePage(),
          //"DetailedPage": (context) => DetailedPage(),
          //"AddDebtPage": (context) => AddDebtPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Debt Collector',
        home: HomePage(),
      ),
    );
  }
}
