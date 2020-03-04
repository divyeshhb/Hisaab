import 'package:flutter/foundation.dart';

class Transactions {
  String id;
  String title;
  double amt;
  DateTime dt;

  Transactions({
    @required this.id,
    @required this.title,
    @required this.amt,
    @required this.dt,
  });
}
