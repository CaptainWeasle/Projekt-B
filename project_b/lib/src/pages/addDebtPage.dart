import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDebtPage extends StatefulWidget {
  State<AddDebtPage> createState() => AddDebtPageState();
}

class AddDebtPageState extends State<AddDebtPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Debt"),
      ),
      body: null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

        },
        icon: Icon(Icons.subdirectory_arrow_left),
        label: Text("OK"),
      ),
    );

  }
}