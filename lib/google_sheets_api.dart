import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsapi {
  static const _creds = r'''
    {
  "type": "service_account",
  "project_id": "expensa-362014",
  "private_key_id": "daba2474f6f35e50017a8227a57fcab0262d4c38",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCIhGkzDDfErb5t\nYY+zYtmcoWgij4o8k0boiP/pypNiNoWqKlmQBjs9B2k8FC9IqLirMty4OL2L/a+7\na3I1vGcYNXGi6e2rELhiEkgR/nJn+nzow3AzukNM2Q4natElIIiZA2IyUUhb5GKg\n6LebciYlRKkAAtxvbcLtBVtWJjUec8xx0pT4NGBrh5Zs5dnmgR1e8PvASm+FfJVU\ngL1TDcfmwyj1VxzbXY3SykSrreclP2blY0F2c7I8IS75CrvBW3DssxrhGAUJW2zz\nTlzH3iPw3w3hjTQp5HvDMLxNmYq372dCGmzY5F4ChCddzzZb3MzFjDZamd4FQpMw\noaxyHwAhAgMBAAECggEACWIG1DCSYxaiyf3OOw25cZ+3+pG6Qv0t/t/u4IpapIHY\nbToWVP6fDH8stBAAsZIqVYn1zBIKS37jy/i2LT9S9Q6agUOdLdUrKk87XBE/zim6\nc0nlG+90N+nxpEy3lA4VlWUhvXecufdYJNsZ4FM+KYpiKAZwt2Mbf9/B+u/XvGbI\nNDNX+WivSFc1Y353z/hKq9kpFKkhPFY6YIooC3aRFlO0H2QQaiGhmpLidBwUNTSO\nQcLsJ/0BxIhzSi9KpP039+/CHaMAcFwbuQE1Fw8miHAc2PcoVXW4UCKgMW1tBS60\nfo1HToHHC7CzspGSVwzlC1FxMppvhRuLNoNYfcIHSQKBgQDACUeqE8H/9ouiQ/Yy\nXN9YVVS7Y8cvEjfJ6Ra7H6huVEnoGxeVeozLLQxCzu16ZNw4qw/72ICwrLNCOIzF\nDIWmR596hnpE9n7sjIvM+TzuXnAZF5SUN3165E5jG+vXhEXYaFBk2t9Gr9SOZJyO\nW2U3Tfkv9k/hurlUbLLxxBYBrwKBgQC1/RXO6QwDyHqAucFueY20hnLYwMcGlCvt\n4pjrcY89JnIFdNL8/UN83gCOus2jNz1E65+pHU2uM1jWnnkBlGcGni5nPJznpKoe\nrP+kDCHnMCqAVUIMPHEWUP9iCMe6GdSFBtY5bTzndEExn6uLwSFONXArDtry7aH7\nyizZCMefLwKBgQCnmrHYiBwG+biPK//Bnvszzm4Aiyo6NA1LBUvYj93iRWCn2pVv\n2iDt52hPGul7rHHkZ7CwnxpamLBvuIlsJeyz3skbGCm47OaEMHqHsHR0myn9TG5a\nGkBDNOYRbDofxIttQEYCcGD1AdtjV/6n5K7nYP9+09yOZ/j+7UwU5I5McwKBgAay\npdbTpOmOu1N5grD6MEjwmdF4ZtrLIULEEDS6HTd27sNcpVdCSvWRhhu6rE7RfaPH\nuDyVI4LByQc9Fd8FAzWvJK4QAQZVfR1b6Jy1BZpon2fRu3iP0OmtWXjWMeObh8LN\nmZzLdG5gTPXylnGyTfN+6/3psg02ybtmmXfzZsVpAoGAMAU6ImAY9/Zy1I93gi/e\nobXH9geXFT66eC+mYTbUqx4lNBGGPdgmtZn+rsiFb4rJ8L1NDf4QL/W0M7k3K/qk\nxBfwE7LTXLyMFTZ7NNz4d5Ooq1X6GnZbdeJGNOtmPwiMJSPFni4R/BZGJVNpvGeX\n+JhT9o484l2so51QRpFTNRU=\n-----END PRIVATE KEY-----\n",
  "client_email": "expensa@expensa-362014.iam.gserviceaccount.com",
  "client_id": "117491560765470264771",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expensa%40expensa-362014.iam.gserviceaccount.com"
}
''';

  static final _spreadsheetId = '1LagyLDMrNf2QZm-5kyIF0G9DchgTNqRsjGo_QR_rBkI';
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
