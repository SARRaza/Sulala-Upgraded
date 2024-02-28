import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:showcaseview/showcaseview.dart';

import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';

class AnimalInfoTutorialPage extends StatefulWidget {
  const AnimalInfoTutorialPage({super.key});

  @override
  State<AnimalInfoTutorialPage> createState() => _AnimalInfoTutorialPage();
}

class _AnimalInfoTutorialPage extends State<AnimalInfoTutorialPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _medicalNeedsController = TextEditingController();

  late final TabController _tabController;

  final GlobalKey _generalOverview = GlobalKey();
  final GlobalKey _clickBreeding = GlobalKey();
  final GlobalKey _clickMedical = GlobalKey();
  final GlobalKey _breedingOverview = GlobalKey();
  final GlobalKey _medicalOverview = GlobalKey();
  final GlobalKey _addMedicalNeeds = GlobalKey();
  final GlobalKey _editButton = GlobalKey();
  final GlobalKey _gotoHomepage = GlobalKey();
  BuildContext? infoContext;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _medicalNeedsController.text = "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(infoContext!).startShowCase([
        _generalOverview,
        _clickBreeding,
        _breedingOverview,
        _clickMedical,
        _medicalOverview,
        _addMedicalNeeds,
        _editButton,
        _gotoHomepage
      ]);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _medicalNeedsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder: Builder(
      builder: ((context) {
        infoContext = context;
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/graphic/Animal_p.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle back button press
                      // Add your code here
                    },
                  ),
                ),
              ),
              actions: [
                Showcase(
                  key: _editButton,
                  targetBorderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  tooltipBackgroundColor:
                      const Color.fromARGB(255, 251, 247, 206),
                  descTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  description: 'Add & Edit Information To Your Animal'.tr,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Handle edit button press
                          // Add your code here
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FractionalTranslation(
                            translation: const Offset(0.0, -0.6),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.16,
                              backgroundColor: Colors.grey[200],
                              child: Image.asset(
                                'assets/avatars/120px/Horse.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0.0,
                          -60.0), // Adjust the Y offset to move the text up
                      child: Column(
                        children: [
                          const Text(
                            'Suhail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'ID# 12345',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const SizedBox(height: 10),
                          IntrinsicWidth(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 242, 122),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  const Icon(Icons.home, color: Colors.black),
                                  const SizedBox(width: 8),
                                  Text(
                                    'My Farm'.tr,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              indicator: BoxDecoration(
                                color: const Color.fromARGB(255, 36, 86, 38),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Colors.transparent,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  text: 'General'.tr,
                                ),
                                Showcase(
                                  key: _clickBreeding,
                                  targetBorderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  tooltipBackgroundColor:
                                      const Color.fromARGB(255, 251, 247, 206),
                                  descTextStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  description: 'Click Here'.tr,
                                  child: SizedBox(
                                    width: double
                                        .infinity, // Make the container take the full width
                                    child: Tab(
                                      text: 'Breeding'.tr,
                                    ),
                                  ),
                                ),
                                Showcase(
                                  key: _clickMedical,
                                  targetBorderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  tooltipBackgroundColor:
                                      const Color.fromARGB(255, 251, 247, 206),
                                  descTextStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  description: 'Click Here'.tr,
                                  child: SizedBox(
                                    width: double
                                        .infinity, // Make the container take the full width
                                    child: Tab(
                                      text: 'Medical'.tr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tab Bar View
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                190 -
                                20 -
                                50,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // General Tab bar Starts
                                SingleChildScrollView(
                                  child: Showcase(
                                    key: _generalOverview,
                                    targetBorderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    tooltipBackgroundColor:
                                        const Color.fromARGB(
                                            255, 251, 247, 206),
                                    descTextStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    description:
                                        'Here You Can Find All The General Info About The Animals'
                                            .tr,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height:
                                                15), // Add spacing between the boxes
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 247, 206),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Mammal'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Type'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Horse'.tr,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Species'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Female'.tr,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Sex'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'General Information'.tr,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 13),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Age'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  'ADD'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Breed'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  'African Horse'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Date Of Hatching'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  'ADD'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .blue, // You can customize the button's color
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Date Of Death'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  'ADD'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .blue, // You can customize the button's color
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Date Of Sale'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: Text(
                                                  'ADD'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .blue, // You can customize the button's color
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Additional Notes'.tr,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            'Notes'.tr,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Uploaded Files To Be Here'.tr,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // General Tab bar Ends
                                //Breeding Tab bar View Starts
                                SingleChildScrollView(
                                  child: Showcase(
                                    key: _breedingOverview,
                                    targetBorderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    tooltipBackgroundColor:
                                        const Color.fromARGB(
                                            255, 251, 247, 206),
                                    descTextStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    description:
                                        'Here You Can Find All The Breeding Details Of The Animals'
                                            .tr,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        // Add spacing between the boxes
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 247, 206),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Pregnant'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Current Status'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 247, 206),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    '12.02.2023',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Last Hatching Date'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    '12.02.2023',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Frequency Of Laying Eggs'
                                                        .tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 13),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                164, 76, 175, 79),
                                            child: Icon(Icons.history,
                                                color: Colors.white),
                                          ),
                                          title: Text('Breeding History'.tr),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                164, 76, 175, 79),
                                            child: Icon(Icons.bedroom_parent,
                                                color: Colors.white),
                                          ),
                                          title: Text('Parents'.tr),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                164, 76, 175, 79),
                                            child: Icon(Icons.route,
                                                color: Colors.white),
                                          ),
                                          title: Text('Family Tree'.tr),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                164, 76, 175, 79),
                                            child: Icon(Icons.man_outlined,
                                                color: Colors.white),
                                          ),
                                          title: Text('Male Mates'.tr),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                164, 76, 175, 79),
                                            child: Icon(Icons.child_friendly,
                                                color: Colors.white),
                                          ),
                                          title: Text('Children'.tr),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Breeding Tab bar View Ends

                                // Medical Tab bar View Starts
                                SingleChildScrollView(
                                  child: Showcase(
                                    key: _medicalOverview,
                                    targetBorderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    tooltipBackgroundColor:
                                        const Color.fromARGB(
                                            255, 251, 247, 206),
                                    descTextStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    description:
                                        'Here You Can Find All The Medical Details Of The Animals'
                                            .tr,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 247, 206),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    '01.01.2023',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Next Vaccination'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 247, 206),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    '12.02.2023',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Last Check Up'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    '02.08.2023',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Next Check Up'.tr,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Medical Needs'.tr,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Showcase(
                                                key: _addMedicalNeeds,
                                                targetBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                tooltipBackgroundColor:
                                                    const Color.fromARGB(
                                                        255, 251, 247, 206),
                                                descTextStyle: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                description:
                                                    'Add Medical Recommendations To The Custom Field'
                                                        .tr,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.edit_square,
                                                    color: Color.fromARGB(
                                                        255, 36, 86, 38),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextFormField(
                                            maxLines:
                                                6, // Set the maximum number of lines
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Add Additional Information If Needed'
                                                      .tr, // Add your hint text here
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 16.0),
                                            ),
                                            textInputAction: TextInputAction
                                                .done, // Change the keyboard action
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Medical Tabbar View Ends
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
            ),
            floatingActionButton: Showcase(
              key: _gotoHomepage,
              targetPadding: const EdgeInsets.all(5),
              targetBorderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              description: 'Click Here To Go To HomePage'.tr,
              descTextStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 36, 86, 38),
                  fontWeight: FontWeight.bold),
              onTargetClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const NavigationBarGuestMode(), // Replace with your desired page.
                  ),
                );
              },
              disposeOnTap: true,
              child: SizedBox(
                height: 70,
                width: 100,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const NavigationBarGuestMode(), // Replace with your desired page.
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  elevation: 10,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_right_alt,
                    size: 54,
                  ),
                ),
              ),
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        );
      }),
    ));
  }
}
