import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
class Transaction{
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
});
}
