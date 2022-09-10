import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsapi {
  static const _creds = r'''

'''; //  Credentials(json)

  static final _spreadsheetId = ''; //spreadsheetid
  static final _gsheets = GSheets(_creds);
  static Worksheet? _sheet;

  static int numberofTrn = 0;
  static List<List<dynamic>> currentTrn = [];
  static bool loading = true;

  Future init() async {
    //fetch spreadsheet
    final gSheetid = await _gsheets.spreadsheet(_spreadsheetId);

    _sheet = gSheetid.worksheetByTitle('expensesheet1');
    countRows();
  }

  static Future countRows() async {
    while (
        (await _sheet!.values.value(column: 1, row: numberofTrn + 1)) != '') {
      numberofTrn++;
    }
    loadTrn();
  }

  static Future loadTrn() async {
    if (_sheet == null) return;

    for (int i = 1; i < numberofTrn; i++) {
      final String trnName = await _sheet!.values.value(column: 1, row: i + 1);
      final String trnAmt = await _sheet!.values.value(column: 2, row: i + 1);
      final String trnType = await _sheet!.values.value(column: 3, row: i + 1);

      if (currentTrn.length < numberofTrn) {
        currentTrn.add([
          trnName,
          trnAmt,
          trnType,
        ]);
      }
    }
    print(currentTrn);
    loading = false;
  }

  static Future insert(String name, String amount, bool _isincome) async {
    if (_sheet == null) return;
    numberofTrn++;
    currentTrn.add([
      name,
      amount,
      _isincome == true ? 'income' : 'expense',
    ]);
    await _sheet!.values.appendRow([
      name,
      amount,
      _isincome == true ? 'income' : 'expense',
    ]);
  }

  static double calculateIncome() {
    double totalinc = 0;
    for (int i = 0; i < currentTrn.length; i++) {
      if (currentTrn[i][2] == 'income') {
        totalinc += double.parse(currentTrn[i][1]);
      }
    }
    return totalinc;
  }

  static double calculateExpense() {
    double totalexp = 0;
    for (int i = 0; i < currentTrn.length; i++) {
      if (currentTrn[i][2] == 'expense') {
        totalexp += double.parse(currentTrn[i][1]);
      }
    }
    return totalexp;
  }
}
