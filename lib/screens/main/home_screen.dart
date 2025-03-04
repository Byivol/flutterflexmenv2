import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'lesson.dart';
import 'lesson_widget.dart';
import 'notification_screen.dart';
import 'qrcode_screen.dart';
import 'refresh_indicator.dart';
import 'getlessons.dart';
import 'schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> _imgList = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var imgPath in _imgList) {
      precacheImage(AssetImage(imgPath), context);
    }
  }

  Future<void> _refreshLessons() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'THE',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),
                TextSpan(
                  text: ' ',
                  style: TextStyle(fontSize: 25, letterSpacing: -2),
                ),
                TextSpan(
                  text: 'FLEX ',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'men | Тюмень',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrCodeScreen()),
            );
          },
          icon: const Icon(Icons.qr_code_scanner),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: '89292615056');
              await launchUrl(launchUri);
            },
            icon: const Icon(Icons.call, size: 26),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications, size: 30),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: CheckMarkIndicator(
        onRefresh: _refreshLessons,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          clipBehavior: Clip.none,
          child: Column(
            children: [
              CarouselSlider.builder(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  autoPlay: true,
                  clipBehavior: Clip.hardEdge,
                ),
                itemCount: _imgList.length,
                itemBuilder: (context, index, realIndex) {
                  return Center(
                    child: Image.asset(
                      _imgList[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 255, 216, 87),
                    ),
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleScreen(),
                        ),
                      );
                    },
                    label: const Text(
                      'Расписание',
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: const Icon(Icons.assignment),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 216, 87),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          label: const Text(
                            'Обратная связь',
                            style: TextStyle(fontSize: 16),
                          ),
                          icon: const Icon(Icons.sms_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 216, 87),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          label: const Text(
                            'Личный кабинет',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(Icons.account_circle_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  onExpansionChanged: (e) {},
                  title: const Text("Ближайшие занятия:"),
                  children: [
                    FutureBuilder<List<Lesson>>(
                      future: getLessonsforDate(DateTime.now()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.black,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Ошибка: ${snapshot.error}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'Нет доступных занятий',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else {
                          final lessons = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lessons.length,
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
                              return LessonWidget(lesson: lesson);
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
