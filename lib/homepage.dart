import 'package:expensa/add_btn.dart';
import 'package:flutter/material.dart';

import 'balance_card.dart';
import 'trn_log.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(children: [
            BalanceCard(
              balance: '500',
              income: '300',
              expense: '200',
            ),
            TrnLog(
              trname: 'salary',
              exporinc: 'income',
              money: '500',
            ),
            AddBtn(),
          ]),
        ));
  }
}
