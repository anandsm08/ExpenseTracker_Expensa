import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsapi {
  static const _creds = r'''
    //credentials from google's API
''';

  static final _spreadsheetId = '//Spreadsheet ID';
  static final _gsheets = GSheets(_creds);
  static Worksheet? _sheet;

  Future init() async {
    //fetch spreadsheet
    final gSheetid = await _gsheets.spreadsheet(_spreadsheetId);

    var _sheet = gSheetid.worksheetByTitle('expensesheet1');
  }
}
