import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../reg_mode/reg_home_page.dart';
import 'animal_info_tutorial.dart';

class RegHomeScreenTutorial extends StatefulWidget {
  const RegHomeScreenTutorial({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegHomeScreenTutorial createState() => _RegHomeScreenTutorial();
}

class _RegHomeScreenTutorial extends State<RegHomeScreenTutorial> {
  final GlobalKey _animaloverview = GlobalKey();
  final GlobalKey _pieChart = GlobalKey();
  final GlobalKey _filter = GlobalKey();
  final GlobalKey _next2 = GlobalKey();
  BuildContext? myContext;

  late List<AnimalData> _chartData;
  int sumOfNextTwoCards = 0;
  List<EventData> events = [
    EventData(title: 'Horse Vaccination', subtitle: '09.01.2023'),
    EventData(title: 'Cow Health Checkup', subtitle: '01.09.2023'),
  ];
  @override
  void initState() {
    _chartData = getChartData();
    sumOfNextTwoCards = _chartData[0].quan + _chartData[1].quan;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(myContext!)
          .startShowCase([_animaloverview, _pieChart, _filter, _next2]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder: Builder(
      builder: ((context) {
        myContext = context;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Overview',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Animals',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Showcase(
                        key: _filter,
                        description:
                            'Use Filters To Create The Chart With More Inputs',
                        descTextStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        targetBorderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: InkWell(
                          // onTap: _showFilterModalSheet,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.filter_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Showcase(
                  key: _animaloverview,
                  targetBorderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  targetPadding: EdgeInsets.all(5),
                  tooltipBackgroundColor:
                      const Color.fromARGB(235, 255, 248, 214),
                  description:
                      'Here You Can Know The Number Of Animals In Your Farm',
                  descTextStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.192,
                          width: MediaQuery.of(context).size.width * 0.282,
                          child: SmallCardWidget(
                            imageAsset:
                                "assets/icons/frame/24px/cow_chicken.png",
                            animalData: AnimalData(
                                'ALL', sumOfNextTwoCards, _chartData[0].color),
                            quan: sumOfNextTwoCards.toString(),
                            onPressed: () {},
                            color: const Color.fromARGB(235, 255, 248,
                                214), // Set the color for the first card
                          ),
                        ),
                      ),
                      Expanded(
                        child: SmallCardWidget(
                          imageAsset: "assets/icons/frame/24px/cow_framed.png",
                          animalData: _chartData[0],
                          quan: _chartData[0].quan.toString(),
                          onPressed: () {},
                          color: const Color.fromARGB(235, 255, 248, 214),
                        ),
                      ),
                      Expanded(
                        child: SmallCardWidget(
                          imageAsset:
                              "assets/icons/frame/24px/chicken_framed.png",
                          animalData: _chartData[1],
                          quan: _chartData[1].quan.toString(),
                          onPressed: () {},
                          color: const Color.fromARGB(235, 255, 248, 214),
                        ),
                      ),
                    ],
                  ),
                ),
                Showcase(
                  key: _pieChart,
                  description:
                      'This PieChart Will Help You Visualize Proportions',
                  targetBorderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  tooltipBackgroundColor:
                      const Color.fromARGB(255, 197, 219, 158),
                  descTextStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 250, // Adjust the width of the chart
                          height: 250, // Adjust the height of the chart
                          child: SfCircularChart(
                            series: <CircularSeries>[
                              DoughnutSeries<AnimalData, String>(
                                dataSource: _chartData,
                                xValueMapper: (AnimalData data, _) =>
                                    data.animal,
                                yValueMapper: (AnimalData data, _) => data.quan,
                                pointColorMapper: (AnimalData data, _) =>
                                    data.color,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: _buildLegendItems(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    EventData eventData = events[index];
                    return ListTile(
                      title: Text(
                        eventData.title,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        eventData.subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CardWidget(
                        imagePath: 'assets/icons/frame/24px/Cow_Icon.png',
                        text: 'Searching For Animals',
                        buttonText: 'Find Animals',
                        onPressed: () {
                          // Handle button 1 press
                        },
                        color: const Color.fromARGB(255, 197, 219,
                            158), // Set the color for the first card
                      ),
                    ),
                    Expanded(
                      child: CardWidget(
                        imagePath: 'assets/icons/frame/24px/Farm_house.png',
                        text: 'Search For\nFarms',
                        buttonText: 'Find Farms',
                        onPressed: () {
                          // Handle button 2 press
                        },
                        color: const Color.fromARGB(255, 254, 255,
                            168), // Set the color for the second card
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Showcase(
            key: _next2,
            targetPadding: EdgeInsets.all(5),
            targetBorderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            description: 'Click Here To Go To Next Page Tutorial',
            descTextStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 36, 86, 38),
                fontWeight: FontWeight.bold),
            onTargetClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AnimalInfoTutorialPage(), // Replace with your desired page.
                ),
              );
            },
            disposeOnTap: true,
            child: Container(
              height: 70,
              width: 100,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AnimalInfoTutorialPage(), // Replace with your desired page.
                    ),
                  );
                },
                backgroundColor: Colors.white,
                elevation: 10,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.arrow_right_alt,
                  size: 54,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      }),
    ));
  }

  List<AnimalData> getChartData() {
    final List<AnimalData> chartData = [
      AnimalData(
        'Mammals',
        12,
        const Color.fromARGB(255, 197, 219, 158),
      ),
      AnimalData(
        'Oviparous',
        25,
        const Color.fromARGB(255, 254, 255, 168),
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

class SmallCardWidget extends StatefulWidget {
  final String imageAsset; // Use an image asset path instead of an icon
  final AnimalData animalData;
  final String quan;
  final VoidCallback onPressed;
  final Color color;
  final bool isSelected; // Added new isSelected property

  const SmallCardWidget({
    required this.imageAsset, // Pass an image asset path
    required this.animalData,
    required this.quan,
    required this.onPressed,
    required this.color,
    this.isSelected = false,
  });

  @override
  _SmallCardWidgetState createState() => _SmallCardWidgetState();
}

class _SmallCardWidgetState extends State<SmallCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (widget
            .isSelected) // Show the back card only when isSelected is true
          Positioned.fill(
            child: Material(
              type: MaterialType.card,
              color: const Color.fromRGBO(
                  225, 219, 190, 1), // Change the color for the back card
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.037),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.0073),
          child: Material(
            type: MaterialType.card,
            elevation:
                widget.isSelected ? 10 : 0, // Set elevation based on isSelected
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.037),
            color: const Color.fromRGBO(249, 245, 236, 1),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  widget.onPressed();
                });
              },
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.037),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.042),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      widget.imageAsset, // Use the provided image asset path
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.014),
                    Text(widget.animalData.animal,
                        style: AppFonts.body2(color: AppColors.grayscale100)),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0034),
                    Text(widget.animalData.quan.toString(),
                        style:
                            AppFonts.headline4(color: AppColors.grayscale100)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  final String imagePath; // Image path for Image.asset
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color, // Set the color of the card
        child: Container(
          width: 150,
          height: 220,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                imagePath, // Use Image.asset with the specified image path
                width: 40, // Set the width of the image
                height: 40, // Set the height of the image
              ),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black), // Set the color of the text
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 36, 86,
                        38), // Set the background color of the button
                  ),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        color:
                            Colors.white), // Set the text color of the button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
