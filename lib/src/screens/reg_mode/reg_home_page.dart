import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/colors/piechart_colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../search/search_page.dart';
import '../search/search_page_animals.dart';
import '../search/search_page_house_farm.dart';
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

  List<AnimalData> getFilteredChartData() {
    if (_selectedIndex == -1) {
      // Show data for 'ALL'
      return getChartData();
    } else if (_selectedIndex == 0) {
      // Show data for 'Mammals'
      return _getSpeciesChartData(mammalSpeciesList);
    } else {
      // Show data for 'Oviparous'
      return _getSpeciesChartData(oviparousSpeciesList);
    }
  }

  List<AnimalData> _getSpeciesChartData(List<String> speciesList) {
    List<AnimalData> chartData = [];

    final currentStateFilterActive = currentStateTags.any((tag) => tag.status ==
        TagStatus.active);
    final medicalStateFilterActive = medicalStateTags.any((tag) => tag.status ==
        TagStatus.active);
    final otherFilterActive = otherStateTags.any((tag) => tag.status ==
        TagStatus.active);
    final filtersActive = currentStateFilterActive || medicalStateFilterActive
        || otherFilterActive;

    if(filtersActive) {
      final animalType = _selectedIndex == 0 ? 'mammal' : 'oviparous';
      final tags = currentStateTags + medicalStateTags + otherStateTags;
      for (var tag in tags) {
        if(tag.status == TagStatus.active) {
          final count = ref.read(ovianimalsProvider).where((animal) =>
          animal.selectedAnimalType.toLowerCase() == animalType &&
              animal.selectedOviChips.contains(tag.name)).toList().length;
          final color = tagColors[tag.name];
          chartData.add(AnimalData(tag.name, count, color!));
        }
      }
    } else {
      final speciesCount = ref.refresh(_selectedIndex == 0
          ? mammalSpeciesCountProvider : oviparousSpeciesCountProvider);
      chartData = speciesList
          .map((species) => AnimalData(species, speciesCount[species] ?? 0,
          Colors.blue)) // Replace Colors.blue with the desired color
          .toList();
    }


    return chartData;
  }

  List<Tag> currentStateTags = [
    Tag(name: 'Borrowed'.tr, status: TagStatus.notActive),
    Tag(name: 'Adopted'.tr, status: TagStatus.notActive),
    Tag(name: 'Donated'.tr, status: TagStatus.notActive),
    Tag(name: 'Escaped'.tr, status: TagStatus.notActive),
    Tag(name: 'Stolen'.tr, status: TagStatus.notActive),
    Tag(name: 'Transferred'.tr, status: TagStatus.notActive),
  ];
  List<Tag> medicalStateTags = [
    Tag(name: 'Injured'.tr, status: TagStatus.notActive),
    Tag(name: 'Sick'.tr, status: TagStatus.notActive),
    Tag(name: 'Quarantined'.tr, status: TagStatus.notActive),
    Tag(name: 'Medication'.tr, status: TagStatus.notActive),
    Tag(name: 'Testing'.tr, status: TagStatus.notActive),
  ];

  List<Tag> otherStateTags = [
    Tag(name: 'Sold'.tr, status: TagStatus.notActive),
    Tag(name: 'Dead'.tr, status: TagStatus.notActive),
  ];

  Map<String, Color> tagColors = {
    'Borrowed': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Adopted': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Donated': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Escaped': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Stolen': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Transferred': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Injured': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Sick': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Quarantined': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Medication': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Testing': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Sold': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    'Dead': Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
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
    sumOfNextTwoCards = _chartData[0].quan + _chartData[1].quan;

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
          child: DrowupWidget(
            heightFactor: 0.73,
            heading: "Tags".tr,
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
    setState(() {
    });
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
                'Overview'.tr,
                style: AppFonts.title3(color: AppColors.grayscale100),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    ),
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
                      Text('Animals'.tr,
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
                              'ALL'.tr, sumOfNextTwoCards, _chartData[0].color),
                          quan: sumOfNextTwoCards.toString(),
                          onPressed: () {
                            _updateChartData(sumOfNextTwoCards, 'ALL'.tr);
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
                            _updateChartData(_chartData[0].quan, 'Mammals'.tr);
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
                            _updateChartData(
                                _chartData[1].quan, 'Oviparous'.tr);
                          },
                          isSelected: _selectedIndex == 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: globals.heightMediaQuery * 16),
                  sumOfNextTwoCards == 0
                      ? Row(
                          children: [
                            SizedBox(
                              width: globals.widthMediaQuery * 20,
                            ),
                            Center(
                              child: Image.asset(
                                "assets/illustrations/pie_chart.png",
                              ),
                            ),
                            SizedBox(
                              width: globals.widthMediaQuery * 50,
                            ),
                            Center(
                              child: Image.asset(
                                "assets/illustrations/_Legend.png",
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: globals.widthMediaQuery * 216,
                              height: globals.heightMediaQuery * 220,
                              child: SfCircularChart(
                                margin: const EdgeInsets.all(0),
                                series: <CircularSeries>[
                                  DoughnutSeries<AnimalData, String>(
                                    dataSource: getFilteredChartData(),
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
                        'Upcoming Events'.tr,
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
                            'You have no upcoming events so far'.tr,
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
                          final ReminderItem dateItem = reminders[index];

                          return GestureDetector(
                            onTap: () => navigateToAnimal(dateItem.animalNames),
                            child: ListTile(
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
                            ),
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
                          title: 'Searching\nfor animals?'.tr,
                          buttonText: 'Find animals'.tr,
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchPageAnimals(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: globals.widthMediaQuery * 6),
                      Expanded(
                        child: CardWidget(
                          color: const Color.fromRGBO(246, 239, 205, 1),
                          iconPath: 'assets/icons/frame/24px/Farm_house.png',
                          title: 'Searching \nfor farm?'.tr,
                          buttonText: 'Find farms'.tr,
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchPageHouseFarm(),
                            ),
                          ),
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
    List<AnimalData> chartData = [];
    final currentStateFilterActive = currentStateTags.any((tag) => tag.status == TagStatus.active);
    final medicalStateFilterActive = medicalStateTags.any((tag) => tag.status == TagStatus.active);
    final otherFilterActive = otherStateTags.any((tag) => tag.status == TagStatus.active);

    bool filtersActive =  currentStateFilterActive || medicalStateFilterActive
        || otherFilterActive;

    if(filtersActive) {
      final tags = currentStateTags + medicalStateTags + otherStateTags;
      for (var tag in tags) {
        if(tag.status == TagStatus.active) {
          final count = ref.read(ovianimalsProvider).where((animal) =>
              animal.selectedOviChips.contains(tag.name)).toList().length;
          final color = tagColors[tag.name];
          chartData.add(AnimalData(tag.name, count, color!));
        }
      }
    } else {
      final mammalCount = ref.refresh(mammalCountProvider);
      final oviparousCount = ref.refresh(oviparousCountProvider);
      chartData = [
        AnimalData(
          'Mammals'.tr,
          mammalCount,
          const Color.fromRGBO(175, 197, 86, 1),
        ),
        AnimalData(
          'Oviparous'.tr,
          oviparousCount,
          const Color.fromARGB(255, 254, 255, 168),
        ),
      ];
    }



    return chartData;
  }

  List<Widget> _buildLegendItems() {
    if (_selectedIndex == -1) {
      final filteredData = getFilteredChartData();

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
    } else {
      List<Widget> legendItems = [];
      final speciesList = _selectedIndex == 0 ? mammalSpeciesList
          : oviparousSpeciesList;

      final currentStateFilterActive = currentStateTags.any((tag) => tag.status ==
          TagStatus.active);
      final medicalStateFilterActive = medicalStateTags.any((tag) => tag.status ==
          TagStatus.active);
      final otherFilterActive = otherStateTags.any((tag) => tag.status ==
          TagStatus.active);
      final filtersActive = currentStateFilterActive || medicalStateFilterActive
          || otherFilterActive;


      if(filtersActive) {
        final tags = currentStateTags + medicalStateTags + otherStateTags;
        final animalType = _selectedIndex == 0 ? 'mammal' : 'oviparous';

        for(var tag in tags) {
          if(tag.status == TagStatus.active) {
            final count = ref.read(ovianimalsProvider).where(
                    (animal) => animal.selectedAnimalType.toLowerCase() ==
                        animalType &&
                    animal.selectedOviChips.contains(tag.name)).toList()
                .length;

            legendItems.add(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: tagColors[tag.name]),
                const SizedBox(width: 4),
                Text('${tag.name.tr}: $count'),
              ],
            ));
          }
        }
      } else {
        final speciesCountProvider = _selectedIndex == 0
            ? mammalSpeciesCountProvider
            : oviparousSpeciesCountProvider;

        final speciesCount = ref.watch(speciesCountProvider);
        final filteredSpeciesList = speciesList.where((species) {
          final count = speciesCount[species] ?? 0;
          return count > 0;
        });

        legendItems = filteredSpeciesList.map((species) {
          final count = speciesCount[species] ?? 0;
          final color = speciesColorMap[species] ?? Colors.blue;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: color),
              const SizedBox(width: 4),
              Text('$species: $count'),
            ],
          );
        }).toList();
      }

      return legendItems;
    }
  }

  void navigateToAnimal(String animalName) {
    final animal = ref.read(ovianimalsProvider).firstWhere(
            (animal) => animal.animalName == animalName);

    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        OwnedAnimalDetailsRegMode(imagePath: '', title: '',
            geninfo: '', OviDetails: animal,
            breedingEvents: [])));
  }
}

class AnimalData {
  AnimalData(this.animal, this.quan, this.color);
  final String animal;
  final int quan;
  final Color color;
}

class SpeciesData {
  SpeciesData(this.animal, this.quan, this.color);
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
