import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import 'show_filter_reg.dart';
import 'small_card_widget.dart';

class HomeScreenRegMode extends ConsumerStatefulWidget {
  const HomeScreenRegMode({super.key});

  @override
  ConsumerState<HomeScreenRegMode> createState() => _RegHomePage();
}

class _RegHomePage extends ConsumerState<HomeScreenRegMode> {
  Future<void> _refreshData() async {
    setState(() {
      _chartData = getChartData();
      sumOfNextTwoCards = _chartData[0].quan + _chartData[1].quan;
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  List<Tag> currentStateTags = [
    Tag(name: 'Borrowed', status: TagStatus.notActive),
    Tag(name: 'Adopted', status: TagStatus.notActive),
    Tag(name: 'Donated', status: TagStatus.notActive),
    Tag(name: 'Escaped', status: TagStatus.notActive),
    Tag(name: 'Stolen', status: TagStatus.notActive),
    Tag(name: 'Transferred', status: TagStatus.notActive),
  ];
  List<Tag> medicalStateTags = [
    Tag(name: 'Injured', status: TagStatus.notActive),
    Tag(name: 'Sick', status: TagStatus.notActive),
    Tag(name: 'Quarantined', status: TagStatus.notActive),
    Tag(name: 'Medication', status: TagStatus.notActive),
    Tag(name: 'Testing', status: TagStatus.notActive),
  ];

  List<Tag> otherStateTags = [
    Tag(name: 'Sold', status: TagStatus.notActive),
    Tag(name: 'Dead', status: TagStatus.notActive),
  ];

  late List<AnimalData> _chartData;
  int sumOfNextTwoCards = 0;
  List<EventData> events = [
    EventData(title: 'Horse Vaccination', subtitle: '09.01.2023'),
    EventData(title: 'Cow Health Checkup', subtitle: '01.09.2023'),
    EventData(title: 'Cow Health Checkup', subtitle: '01.09.2023'),
    EventData(title: 'Cow Health Checkup', subtitle: '01.09.2023'),
    EventData(title: 'Cow Health Checkup', subtitle: '01.09.2023'),
  ];
  int _selectedIndex = -1;

  void updateCurrentTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = currentStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      currentStateTags[tagIndex].status = updatedStatus;
    }
  }

  void updateMedicalTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = medicalStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      medicalStateTags[tagIndex].status = updatedStatus;
    }
  }

  void updateOtherTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = otherStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      otherStateTags[tagIndex].status = updatedStatus;
    }
  }

  @override
  void initState() {
    _chartData = getChartData();
    sumOfNextTwoCards = _chartData[0].quan;
    super.initState();
  }

  void _updateChartData(int newQuan, String animalName) {
    for (int i = 0; i < _chartData.length; i++) {
      if (_chartData[i].animal == animalName) {
        _chartData[i] = AnimalData(animalName, newQuan, _chartData[i].color);
        break;
      }
    }
    setState(() {
      // Trigger a rebuild of the widget
      _selectedIndex =
          _chartData.indexWhere((data) => data.animal == animalName);
    });
  }

  void _showFilterModalSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrowupWidget(
            heightFactor: 0.73,
            heading: "Tags",
            content: ShowFilterReg(
              currentStateTags: currentStateTags,
              medicalStateTags: medicalStateTags,
              otherStateTags: otherStateTags,
              updatedCurrentTagStatus: updateCurrentTagStatus,
              updatedMedicalTagStatus: updateMedicalTagStatus,
              updatedOtherTagStatus: updateOtherTagStatus,
            ),
          ),
        );
      },
    );
  }

  void _removeEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(remindersProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overview',
                style: AppFonts.title3(color: AppColors.grayscale100),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/search');
                    },
                    child: const Image(
                      image:
                          AssetImage('assets/icons/frame/24px/Icon-button.png'),
                    ),
                  ),
                  SizedBox(width: globals.widthMediaQuery * 3.75),
                  GestureDetector(
                    onTap: () {
                      _removeEvent(1);
                      Navigator.of(context).pushNamed('/notifications');
                    },
                    child: events.isNotEmpty
                        ? badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              padding:
                                  EdgeInsets.all(8 * globals.widthMediaQuery),
                            ),
                            badgeContent: Text(
                              events.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            badgeAnimation: const badges.BadgeAnimation.slide(
                              disappearanceFadeAnimationDuration:
                                  Duration(milliseconds: 50),
                              curve: Curves.easeInCubic,
                            ),
                            child: const Image(
                              image: AssetImage(
                                  'assets/icons/frame/24px/Icon-button1.png'),
                            ),
                          )
                        : const Image(
                            image: AssetImage(
                                'assets/icons/frame/24px/Icon-button1.png'),
                          ),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors
              .transparent, // Set the appbar background color to transparent
          elevation: 0, // Remove the appbar shadow
        ),
        body: RefreshIndicator(
          color: AppColors.primary40,
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: globals.widthMediaQuery * 16,
                  right: globals.widthMediaQuery * 16,
                  top: globals.heightMediaQuery * 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Animals',
                          style: AppFonts.title4(color: AppColors.grayscale90)),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _showFilterModalSheet(context);
                        },
                        child: const Image(
                          image:
                              AssetImage('assets/icons/frame/24px/filter1.png'),
                        ),
                      ),
                      SizedBox(width: globals.widthMediaQuery * 22),
                    ],
                  ),
                  SizedBox(height: globals.heightMediaQuery * 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: globals.heightMediaQuery * 148,
                        width: globals.widthMediaQuery * 106,
                        child: SmallCardWidget(
                          icon: Image.asset(
                            "assets/icons/frame/24px/cow_chicken.png",
                            width: globals.widthMediaQuery * 48,
                          ),
                          animalData: AnimalData(
                              'ALL', sumOfNextTwoCards, _chartData[0].color),
                          quan: sumOfNextTwoCards.toString(),
                          onPressed: () {
                            _updateChartData(sumOfNextTwoCards, 'ALL');
                          },
                          isSelected: _selectedIndex == -1,
                        ),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 148,
                        width: globals.widthMediaQuery * 106,
                        child: SmallCardWidget(
                          icon: Image.asset(
                            "assets/icons/frame/24px/cow_framed.png",
                            width: globals.widthMediaQuery * 48,
                          ),
                          quan: _chartData[0].quan.toString(),
                          animalData: _chartData[0],
                          onPressed: () {
                            _updateChartData(_chartData[0].quan, 'Mammals');
                          },
                          isSelected: _selectedIndex == 0,
                        ),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 148,
                        width: globals.widthMediaQuery * 106,
                        child: SmallCardWidget(
                          icon: Image.asset(
                            "assets/icons/frame/24px/chicken_framed.png",
                            width: globals.widthMediaQuery * 48,
                          ),
                          animalData: _chartData[1],
                          quan: _chartData[1].quan.toString(),
                          onPressed: () {
                            _updateChartData(_chartData[1].quan, 'Oviparous');
                          },
                          isSelected: _selectedIndex == 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: globals.heightMediaQuery * 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: globals.widthMediaQuery * 216,
                        height: globals.heightMediaQuery * 220,
                        child: SfCircularChart(
                          margin: const EdgeInsets.all(0),
                          series: <CircularSeries>[
                            DoughnutSeries<AnimalData, String>(
                              dataSource: _chartData,
                              xValueMapper: (AnimalData data, _) => data.animal,
                              yValueMapper: (AnimalData data, _) => data.quan,
                              pointColorMapper: (AnimalData data, _) =>
                                  data.quan == 0 ? Colors.grey : data.color,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: _buildLegendItems(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (reminders.isNotEmpty)
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/frame/24px/24_Warning-circled.png',
                              width: globals.widthMediaQuery * 22,
                            ),
                            SizedBox(width: globals.widthMediaQuery * 12),
                          ],
                        ),
                      Text(
                        'Upcoming Events',
                        style: AppFonts.title4(color: AppColors.grayscale90),
                      ),
                    ],
                  ),
                  SizedBox(height: globals.heightMediaQuery * 12),
                  if (reminders.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/illustrations/calendar_x.png',
                          ),
                          SizedBox(height: globals.heightMediaQuery * 12),
                          Text(
                            'You have no upcoming events so far',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                        ],
                      ),
                    ),
                  if (reminders.isNotEmpty)
                    SizedBox(
                      height: globals.heightMediaQuery * 130,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reminders.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DateItem dateItem = reminders[index];

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Text(
                                  dateItem.animalNames,
                                  style: AppFonts.body1(
                                      color: AppColors.grayscale90),
                                ),
                                SizedBox(width: globals.widthMediaQuery * 4),
                                Text(
                                  dateItem.dateType,
                                  style: AppFonts.body1(
                                      color: AppColors.grayscale90),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              dateItem.dateInfo,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale60),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_rounded,
                                color: AppColors.primary40,
                                size: globals.widthMediaQuery * 12.75),
                            // You can customize the ListTile as per your requirements
                          );
                        },
                      ),
                    ),
                  SizedBox(height: globals.heightMediaQuery * 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CardWidget(
                          color: const Color.fromRGBO(225, 236, 185, 1),
                          iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
                          title: 'Searching\nfor animals?',
                          buttonText: 'Find animals',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/search_animals');
                          },
                        ),
                      ),
                      SizedBox(width: globals.widthMediaQuery * 6),
                      Expanded(
                        child: CardWidget(
                          color: const Color.fromRGBO(246, 239, 205, 1),
                          iconPath: 'assets/icons/frame/24px/Farm_house.png',
                          title: 'Searching \nfor farm?',
                          buttonText: 'Find farms',
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/search_house_farm');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: globals.heightMediaQuery * 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<AnimalData> getChartData() {
    final int mammalCount = ref.refresh(mammalCountProvider);
    final int oviparousCount = ref.refresh(oviparousCountProvider);

    // Check if counts are zero and set colors accordingly
    final Color mammalColor =
        mammalCount > 0 ? const Color.fromRGBO(175, 197, 86, 1) : Colors.grey;
    final Color oviparousColor = oviparousCount > 0
        ? const Color.fromRGBO(244, 233, 174, 1)
        : Colors.grey;

    final List<AnimalData> chartData = [
      AnimalData(
        'Mammals',
        mammalCount,
        mammalColor,
      ),
      AnimalData(
        'Oviparous',
        oviparousCount,
        oviparousColor,
      ),
    ];
    return chartData;
  }

  List<Widget> _buildLegendItems() {
    return _chartData.map((data) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: data.color),
          const SizedBox(width: 4),
          Text('${data.animal}: ${data.quan}'),
        ],
      );
    }).toList();
  }
}

class AnimalData {
  AnimalData(this.animal, this.quan, this.color);
  final String animal;
  final int quan;
  final Color color;
}

class EventData {
  final String title;
  final String subtitle;

  EventData({required this.title, required this.subtitle});
}

class Tag {
  final String name;
  TagStatus status;

  Tag({required this.name, required this.status});
}
