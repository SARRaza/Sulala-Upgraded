import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/widgets/other/tutorial_overlay.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../theme/colors/colors.dart';
import '../../theme/colors/pie_chart_colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';
import '../reg_mode/reg_home_page.dart';
import '../reg_mode/show_filter_reg.dart';
import '../reg_mode/small_card_widget.dart';
import 'animal_management_tutorial.dart';

class RegHomeScreenTutorial extends StatefulWidget {
  const RegHomeScreenTutorial({super.key});

  @override
  State<RegHomeScreenTutorial> createState() => _RegHomeScreenTutorialState();
}

class _RegHomeScreenTutorialState extends State<RegHomeScreenTutorial> {
  final GlobalKey _animalOverview = GlobalKey();
  final GlobalKey _filter = GlobalKey();
  BuildContext? showCaseContext;

  @override
  void initState() {
    super.initState();
    _chartData = _getChartData();
    sumOfNextTwoCards = _chartData[0].quan + _chartData[1].quan;
  }

  Future<void> _refreshData() async {
    setState(() {
      _chartData = _getChartData();
      sumOfNextTwoCards = _chartData[0].quan + _chartData[1].quan;
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  List<AnimalData> _getFilteredChartData() {
    return _getChartData();
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

  Map<String, Color> tagColors = {
    'Borrowed':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Adopted':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Donated':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Escaped':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Stolen':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Transferred':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Injured':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Sick':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Quarantined':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Medication':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Testing':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Sold':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Dead':
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  };

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

  void _updateCurrentTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = currentStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      currentStateTags[tagIndex].status = updatedStatus;
    }
  }

  void _updateMedicalTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = medicalStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      medicalStateTags[tagIndex].status = updatedStatus;
    }
  }

  void _updateOtherTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = otherStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      otherStateTags[tagIndex].status = updatedStatus;
    }
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

  Future<void> _showFilterModalSheet(BuildContext context) async {
    await showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrawUpWidget(
            heightFactor: 0.73,
            heading: "Tags".tr,
            content: ShowFilterReg(
              currentStateTags: currentStateTags,
              medicalStateTags: medicalStateTags,
              otherStateTags: otherStateTags,
              updatedCurrentTagStatus: _updateCurrentTagStatus,
              updatedMedicalTagStatus: _updateMedicalTagStatus,
              updatedOtherTagStatus: _updateOtherTagStatus,
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double lineWidth = totalWidth / 3;

    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview'.tr,
                    style: AppFonts.title3(color: AppColors.grayscale100),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Image(
                          image: AssetImage(
                              'assets/icons/frame/24px/Icon-button.png'),
                        ),
                      ),
                      SizedBox(
                          width: SizeConfig.widthMultiplier(context) * 3.75),
                      GestureDetector(
                        onTap: () {},
                        child: events.isNotEmpty
                            ? badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: EdgeInsets.all(8 *
                                SizeConfig.widthMultiplier(context)),
                          ),
                          badgeContent: Text(
                            events.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          badgeAnimation:
                          const badges.BadgeAnimation.slide(
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
                      left: SizeConfig.widthMultiplier(context) * 16,
                      right: SizeConfig.widthMultiplier(context) * 16,
                      top: SizeConfig.heightMultiplier(context) * 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        key: _animalOverview,
                        children: [
                          Row(
                            children: [
                              Text('Animals'.tr,
                                  style: AppFonts.title4(
                                      color: AppColors.grayscale90)),
                              const Spacer(),
                              InkWell(
                                key: _filter,
                                onTap: () {
                                  _showFilterModalSheet(context);
                                },
                                child: const Image(
                                  image: AssetImage(
                                      'assets/icons/frame/24px/filter1.png'),
                                ),
                              ),
                              SizedBox(
                                  width:
                                  SizeConfig.widthMultiplier(context) * 22),
                            ],
                          ),
                          SizedBox(
                              height: SizeConfig.heightMultiplier(context) * 12),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height:
                                    SizeConfig.heightMultiplier(context) * 148,
                                    width:
                                    SizeConfig.widthMultiplier(context) * 106,
                                    child: SmallCardWidget(
                                      icon: Image.asset(
                                        "assets/icons/frame/24px/cow_chicken.png",
                                        width: SizeConfig.widthMultiplier(context) *
                                            48,
                                      ),
                                      animalData: AnimalData('ALL'.tr,
                                          sumOfNextTwoCards, _chartData[0].color),
                                      quan: sumOfNextTwoCards.toString(),
                                      onPressed: () {
                                        _updateChartData(
                                            sumOfNextTwoCards, 'ALL'.tr);
                                      },
                                      isSelected: _selectedIndex == -1,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                    SizeConfig.heightMultiplier(context) * 148,
                                    width:
                                    SizeConfig.widthMultiplier(context) * 106,
                                    child: SmallCardWidget(
                                      icon: Image.asset(
                                        "assets/icons/frame/24px/cow_framed.png",
                                        width: SizeConfig.widthMultiplier(context) *
                                            48,
                                      ),
                                      quan: _chartData[0].quan.toString(),
                                      animalData: _chartData[0],
                                      onPressed: () {
                                        _updateChartData(
                                            _chartData[0].quan, 'Mammals'.tr);
                                      },
                                      isSelected: _selectedIndex == 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                    SizeConfig.heightMultiplier(context) * 148,
                                    width:
                                    SizeConfig.widthMultiplier(context) * 106,
                                    child: SmallCardWidget(
                                      icon: Image.asset(
                                        "assets/icons/frame/24px/chicken_framed.png",
                                        width: SizeConfig.widthMultiplier(context) *
                                            48,
                                      ),
                                      animalData: _chartData[1],
                                      quan: _chartData[1].quan.toString(),
                                      onPressed: () {
                                        _updateChartData(
                                            _chartData[1].quan, 'Oviparous'.tr);
                                      },
                                      isSelected: _selectedIndex == 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier(context) * 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                    SizeConfig.widthMultiplier(context) * 216,
                                    height:
                                    SizeConfig.heightMultiplier(context) * 220,
                                    child: SfCircularChart(
                                      margin: const EdgeInsets.all(0),
                                      series: <CircularSeries>[
                                        DoughnutSeries<AnimalData, String>(
                                          dataSource: _getFilteredChartData(),
                                          xValueMapper: (AnimalData data, _) =>
                                          data.animal,
                                          yValueMapper: (AnimalData data, _) =>
                                          data.quan,
                                          pointColorMapper: (AnimalData data, _) =>
                                          data.quan == 0
                                              ? Colors.grey
                                              : speciesColorMap[data.animal] ??
                                              data.color,
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
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Upcoming Events'.tr,
                            style:
                            AppFonts.title4(color: AppColors.grayscale90),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 12),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/illustrations/calendar_x.png',
                            ),
                            SizedBox(
                                height: SizeConfig.heightMultiplier(context) *
                                    12),
                            Text(
                              'You have no upcoming events so far'.tr,
                              style: AppFonts.body2(
                                  color: AppColors.grayscale70),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CardWidget(
                                color: const Color.fromRGBO(225, 236, 185, 1),
                                iconPath:
                                'assets/icons/frame/24px/Cow_Icon.png',
                                title: 'Searching\nfor animals?'.tr,
                                buttonText: 'Find animals'.tr,
                                onPressed: () {}),
                          ),
                          SizedBox(
                              width: SizeConfig.widthMultiplier(context) * 6),
                          Expanded(
                            child: CardWidget(
                                color: const Color.fromRGBO(246, 239, 205, 1),
                                iconPath:
                                'assets/icons/frame/24px/Farm_house.png',
                                title: 'Searching \nfor farm?'.tr,
                                buttonText: 'Find farms'.tr,
                                onPressed: () {}),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 24),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Stack(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 60,
                    child: BottomNavigationBar(
                      iconSize: SizeConfig.widthMultiplier(context) * 24,
                      currentIndex: 0,
                      onTap: (index) {},
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.home_outlined),
                          activeIcon: const Icon(Icons.home),
                          label: 'Home'.tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/icons/frame/24px/Outlined_Cow_Icon.png",
                            scale: 24 /
                                (SizeConfig.widthMultiplier(context) * 24),
                          ),
                          activeIcon: Image.asset(
                            "assets/icons/frame/24px/Filled_Cow_Icon.png",
                            scale: 24 /
                                (SizeConfig.widthMultiplier(context) * 24),
                          ),
                          label: 'Animals'.tr,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.account_circle_outlined),
                          activeIcon: const Icon(Icons.account_circle),
                          label: 'Profile'.tr,
                        )
                      ],
                      selectedItemColor: AppColors.primary20,
                      unselectedItemColor: AppColors.grayscale50,
                      selectedLabelStyle:
                      AppFonts.caption3(color: AppColors.primary20),
                      unselectedLabelStyle:
                      AppFonts.caption3(color: AppColors.grayscale50),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: totalWidth,
                    height: 1.0,
                    color: AppColors.grayscale20,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: lineWidth,
                    height: 2.0,
                    color: AppColors.primary20,
                  ),
                ),
              ],
            )),
        TutorialOverlay(
            steps: [_animalOverview, _filter],
            hints: const [
              'Here you can see the number of animals on your farm. A pie chart will help visualize proportions',
              'Use filters to create a chart with more input'
            ],
            onFinished: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AnimalManagementTutorial()))
        )
      ],
    );
  }

  List<AnimalData> _getChartData() {
    return [
      AnimalData(
        'Mammals'.tr,
        12,
        const Color.fromARGB(255, 197, 219, 158),
      ),
      AnimalData(
        'Oviparous'.tr,
        25,
        const Color.fromARGB(255, 254, 255, 168),
      ),
    ];
  }

  List<Widget> _buildLegendItems() {
    final filteredData = _getFilteredChartData();

    return filteredData.map((data) {
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

  List<Widget> _buildShowcaseActions() {
    return [
      Positioned(
        top: 51,
        right: 16,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NavigationBarGuestMode(),
                ),
              );
            },
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const CircleBorder(),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: Image(
                image: AssetImage('assets/icons/frame/24px/24_Close.png'),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        right: 16,
        bottom: 91,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {

            },
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const CircleBorder(),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: Image(
                image: AssetImage('assets/icons/frame/24px/24_Arrow_right.png'),
              ),
            ),
          ),
        ),
      )
    ];
  }
}
