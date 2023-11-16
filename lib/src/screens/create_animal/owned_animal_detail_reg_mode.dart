import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';
import '../medical/mammals_medical.dart';

class OwnedAnimalDetailsRegMode extends StatefulWidget {
  final String imagePath;
  final String title;
  final String geninfo;

  const OwnedAnimalDetailsRegMode({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.geninfo,
  }) : super(key: key);

  @override
  State<OwnedAnimalDetailsRegMode> createState() =>
      _OwnedAnimalDetailsRegModeState();
}

class _OwnedAnimalDetailsRegModeState extends State<OwnedAnimalDetailsRegMode>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: globals.widthMediaQuery * 56,
          leading: Padding(
            padding: EdgeInsets.only(left: globals.widthMediaQuery * 16),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.grayscale10, shape: BoxShape.circle),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: globals.widthMediaQuery * 24,
                ),
                onPressed: () {
                  // Handle close button press
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: globals.widthMediaQuery * 16),
              child: Container(
                width: globals.widthMediaQuery * 40,
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                      'assets/icons/frame/24px/edit_icon_button.png'),
                  onPressed: () {
                    // Handle close button press
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: globals.widthMediaQuery * 375,
                child: Image.asset(
                  "assets/graphic/Animal_p.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              top: globals.heightMediaQuery * 185,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      globals.heightMediaQuery * 32,
                    ),
                    topRight: Radius.circular(globals.widthMediaQuery * 32),
                  ),
                ),
                child: const SizedBox(), // Add your content here
              ),
            ),
            Center(
              child: FractionalTranslation(
                translation: Offset(0, globals.heightMediaQuery * 0.15),
                child: Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: globals.widthMediaQuery * 60,
                        backgroundImage: AssetImage(widget.imagePath),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      Text(
                        widget.title,
                        style: AppFonts.title4(color: AppColors.grayscale90),
                      ),
                      Text(
                        "ID #${widget.title}",
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: globals.widthMediaQuery * 16,
                            right: globals.widthMediaQuery * 16),
                        child: Column(
                          children: [
                            IntrinsicWidth(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Tags(
                                    text: 'Mammal',
                                    icon: null,
                                    onPress: () {
                                      // Handle tag click
                                    },
                                    status: TagStatus.active,
                                  ),
                                  SizedBox(
                                    width: globals.widthMediaQuery * 8,
                                  ),
                                  Tags(
                                    text: 'Herbivore',
                                    icon: null,
                                    onPress: () {
                                      // Handle tag click
                                    },
                                    status: TagStatus.active,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 32,
                            ),
                            Container(
                              height: globals.heightMediaQuery * 44,
                              decoration: BoxDecoration(
                                color: AppColors.grayscale10,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  color: AppColors.primary50,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: Colors.transparent,
                                labelColor: AppColors.grayscale0,
                                unselectedLabelColor: AppColors.grayscale60,
                                labelStyle:
                                    AppFonts.body2(color: AppColors.grayscale0),
                                tabs: const [
                                  Tab(text: 'General'),
                                  Tab(text: 'Breeding'),
                                  Tab(text: 'Medical'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 24,
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 325,
                              width: globals.widthMediaQuery * 341,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Content for the 'General' tab
                                  GeneralInfoAnimalWidget(
                                    onDateOfBirthPressed: () {},
                                    onDateOfDeathPressed: () {},
                                    onDateOfMatingPressed: () {},
                                    onDateOfSalePressed: () {},
                                    onDateOfWeaningPressed: () {},
                                    age: "3 years",
                                    type: "Mammal",
                                    sex: "Female",
                                  ),

                                  // Content for the 'Breeding' tab
                                  const BreedingInfo(),

                                  // Content for the 'Medical' tab
                                  const MammalsMedical(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
