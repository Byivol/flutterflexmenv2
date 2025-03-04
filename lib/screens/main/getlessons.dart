import 'package:cloud_firestore/cloud_firestore.dart';

import 'lesson.dart';

Future<List<Lesson>> getLessonsforDate(DateTime date) async {
  final timezoneOffset = Duration(hours: 2);
  final startOfDay = DateTime(
    date.year,
    date.month,
    date.day,
    0,
    0,
    0,
  ).subtract(timezoneOffset);
  final endOfDay = DateTime(
    date.year,
    date.month,
    date.day,
    23,
    59,
    59,
    999,
  ).subtract(timezoneOffset);

  final querySnapshot =
      await FirebaseFirestore.instance
          .collection('lessons')
          .where('datetimestart', isGreaterThanOrEqualTo: startOfDay)
          .where('datetimestart', isLessThanOrEqualTo: endOfDay)
          .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();

    return Lesson(
      name: data['name'] ?? 'Без названия',
      nameteach: data['nameteach'] ?? 'Неизвестный преподаватель',
      availableSeats: data['availableseats'] ?? 0,
      datetimestart: (data['datetimestart'] as Timestamp).toDate(),
      color: data['color'],
      time: data['time'],
    );
  }).toList();
}
