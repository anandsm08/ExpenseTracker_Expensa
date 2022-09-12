import 'package:flutter/material.dart';

class TrnLog extends StatelessWidget {
  final String trname;
  final String money;
  final String exporinc;

  const TrnLog({
    Key? key,
    required this.trname,
    required this.money,
    required this.exporinc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.grey[100],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[500]),
                          child: Center(
                            child: Icon(
                              Icons.attach_money_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(trname,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            )),
                      ],
                    ),
                    Text(
                      (exporinc == 'expense' ? '-' : '+') + 'Rs.' + money,
                      style: TextStyle(
                          fontSize: 16,
                          color: (exporinc == 'expense'
                              ? Colors.red[300]
                              : Colors.green[300])),
                    )
                  ]))),
    );
  }
}
