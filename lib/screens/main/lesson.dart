import 'package:flutter/foundation.dart';

@immutable
class Lesson {
  final String name;
  final String nameteach;
  final int availableSeats;
  final DateTime datetimestart;
  final String color;
  final int time;

  const Lesson({
    required this.name,
    required this.nameteach,
    required this.availableSeats,
    required this.datetimestart,
    required this.color,
    required this.time,
  });
}
