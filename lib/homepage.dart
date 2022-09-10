import 'dart:async';

import 'add_btn.dart';
import 'package:expensa/google_sheets_api.dart';
import 'package:flutter/material.dart';

import 'balance_card.dart';
import 'loading_screen.dart';
import 'trn_log.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
} //10.28/16.30

class _HomePageState extends State<HomePage> {
  bool _isincome = false;
  final _formkey = GlobalKey<FormState>();
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();

  void _enterTrn() {
    GoogleSheetsapi.insert(
        _textcontrollerITEM.text, _textcontrollerAMOUNT.text, _isincome);
    setState(() {});
  }

  void _newTrn() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Transaction'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Expense'),
                      Switch(
                        value: _isincome,
                        onChanged: (newvalue) {
                          setState(() {
                            _isincome = newvalue;
                          });
                        },
                      ),
                      Text('Income'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formkey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ' Amount ?'),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter Amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'WHY??',
                          ),
                          controller: _textcontrollerITEM,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey[400],
                child: Text('Enter', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _enterTrn();
                  Navigator.of(context).pop();
                }
              })
            ],
          );
        });
  }

  bool session = false;
  void apploading() {
    session = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsapi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsapi.loading == true && session == false) {
      apploading();
    }
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(children: [
            BalanceCard(
              balance: (GoogleSheetsapi.calculateIncome() -
                      GoogleSheetsapi.calculateExpense())
                  .toString(),
              income: GoogleSheetsapi.calculateIncome().toString(),
              expense: GoogleSheetsapi.calculateExpense().toString(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: GoogleSheetsapi.currentTrn.length,
                  itemBuilder: (context, index) {
                    return TrnLog(
                        trname: GoogleSheetsapi.currentTrn[index][0],
                        money: GoogleSheetsapi.currentTrn[index][1],
                        exporinc: GoogleSheetsapi.currentTrn[index][2]);
                  }),
            ),
            AddBtn(
              function: _newTrn,
            ),
          ]),
        ));
  }
}
