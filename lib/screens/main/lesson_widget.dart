import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'lesson.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday =
        lesson.datetimestart.year == now.year &&
        lesson.datetimestart.month == now.month &&
        lesson.datetimestart.day == now.day;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AddObjectDetailsScreen(
                    nameLesson: lesson.name,
                    colorBorder: Color(
                      int.parse('FF${lesson.color}', radix: 16),
                    ),
                  ),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 4,
                height: 60,
                color: Color(int.parse('FF${lesson.color}', radix: 16)),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              isToday
                  ? 'Сегодня\n${DateFormat('HH:mm').format(lesson.datetimestart)}\n${lesson.time} мин.'
                  : '${DateFormat('dd.MM.yyyy').format(lesson.datetimestart)}\n${DateFormat('HH:mm').format(lesson.datetimestart)}\n${lesson.time} мин.',
              style: const TextStyle(
                height: 0,
                fontSize: 14,
                color: Color.fromARGB(169, 0, 0, 0),
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 30),
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: lesson.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '\nСвобоно: ${lesson.availableSeats}',
                    style: const TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: '\n${lesson.nameteach}',
                    style: const TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color.fromARGB(153, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}

class AddObjectDetailsScreen extends StatelessWidget {
  final String nameLesson;
  final Color colorBorder;
  const AddObjectDetailsScreen({
    super.key,
    required this.nameLesson,
    required this.colorBorder,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(nameLesson, style: const TextStyle(fontSize: 20)),
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Закрыть',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: colorBorder, height: 4.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(nameLesson),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {},
              child: Text('Записаться', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
