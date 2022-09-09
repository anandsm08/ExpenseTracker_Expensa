import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;
  const BalanceCard({
    Key? key,
    required this.balance,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(-4.0, -4.0),
              ),
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(5.0, 5.0),
              ),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 35,
          ),
          Text(
            'BALANCE',
            style: TextStyle(color: Colors.grey[700], fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rs.',
                style: TextStyle(color: Colors.grey[800], fontSize: 24),
              ),
              Text(
                '$balance',
                style: TextStyle(color: Colors.grey[850], fontSize: 28),
              ),
            ],
          ),
          SizedBox(
            height: 85,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(-4.0, -3.0),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(3.0, 4.0),
                              ),
                            ]),
                        child: Icon(Icons.call_received)),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text(
                          'INCOME',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        Text(
                          'Rs.$income',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(-3.0, -4.0),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(4.0, 3.0),
                              ),
                            ]),
                        child: Icon(Icons.call_made)),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text('EXPENSES',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16)),
                        Text(
                          'Rs.$expense',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
