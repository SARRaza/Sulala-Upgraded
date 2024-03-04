import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/sar_animal_filters.dart';
import 'package:sulala_upgrade/src/screens/tutorials.dart/animal_info_tutorial.dart';
import 'package:sulala_upgrade/src/widgets/pages/main_widgets/navigation_bar_reg_mode.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';


class AnimalManagementTutorial extends StatefulWidget {
  const AnimalManagementTutorial({super.key});

  @override
  State<AnimalManagementTutorial> createState() => _AnimalManagementTutorialState();
}

class _AnimalManagementTutorialState extends State<AnimalManagementTutorial> {
  String filterQuery = '';
  Timer? _debounce;
  BuildContext? showCaseContext;
  final GlobalKey addAnimal = GlobalKey();
  final GlobalKey addAnimal2 = GlobalKey();

  Future<void> _refreshOviAnimals() async {
    // Add your logic to refresh the list here
    // For example, you can fetch new data or update existing data
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay

    // Call _updateFilteredOviAnimals to apply filters on the refreshed list
    _updateFilteredOviAnimals(query: filterQuery);
  }

  @override
  void initState() {
    super.initState();
    _updateFilteredOviAnimals();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(showCaseContext!)
          .startShowCase([addAnimal]);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _filterMammals(String query) {
    setState(() {
      filterQuery = query;
      _updateFilteredOviAnimals(query: query);
    });
  }

  void _updateFilteredOviAnimals({String? query}) {}

  @override
  Widget build(
      BuildContext context,
      ) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          showCaseContext = context;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0.0,
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.widthMultiplier(context) * 16),
                  child: Text(
                    'Animals'.tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                ),
                leadingWidth: SizeConfig.widthMultiplier(context) * 56,
                leading: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.widthMultiplier(context) * 16),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.grayscale10, shape: BoxShape.circle),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                          size: SizeConfig.widthMultiplier(context) * 24,
                        ),
                        onPressed: () {
                        }, // Call the addAnimal function when the button is pressed
                      ),
                    )),
                actions: [
                  Showcase(
                    disableBarrierInteraction: true,
                    disableDefaultTargetGestures: true,
                    actions: _buildShowcaseActions(),
                    tooltipBackgroundColor: Colors.transparent,
                    descTextStyle: AppFonts.headline1(
                        color: AppColors.grayscale00),
                    key: addAnimal,
                    targetPadding: const EdgeInsets.all(16),
                    description:
                    'Start filling your farm by adding an animal'
                        .tr,
                    targetShapeBorder: const CircleBorder(),
                    child: IconButton(
                      icon: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary50,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                      onPressed: () {

                      }, // Call the addAnimal function when the button is pressed
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: _refreshOviAnimals,
                notificationPredicate: (ScrollNotification notification) {
                  return notification.depth == 1;
                },
                color: AppColors.primary40,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.widthMultiplier(context) * 16,
                        right: SizeConfig.widthMultiplier(context) * 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.029,
                        ),
                        ButtonSearchBar(
                          onChange: _onSearchChanged,
                          hintText: "Search by name or ID".tr,
                          showFilterIcon: true,
                          // controller: _searchController,
                          onIconPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SarAnimalFilters()),
                            );
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 20,
                        ),
                        SingleChildScrollView(
                          child: Center(
                            heightFactor: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/illustrations/cow_search.png',
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.04,
                                ),
                                Text(
                                  'No Animals Found'.tr,
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                Text(
                                  'Try adjusting the filters'.tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale70),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.03,
                                ),
                                Showcase(
                                  disableBarrierInteraction: true,
                                  disableDefaultTargetGestures: true,
                                  actions: _buildShowcaseActions(),
                                  tooltipBackgroundColor: Colors.transparent,
                                  descTextStyle: AppFonts.headline1(
                                      color: AppColors.grayscale00),
                                  key: addAnimal2,
                                  targetPadding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 60
                                  ),
                                  description:
                                  ''
                                      .tr,
                                  targetBorderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  child: SizedBox(
                                    height: 52 *
                                        SizeConfig.heightMultiplier(
                                            context),
                                    child: PrimaryButton(
                                      onPressed: () {
                                  
                                      }, // Call the addAnimal function when the button is pressed
                                      text: 'Add Animal'.tr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Implement your search logic here
      _filterMammals(query);
    });
  }

  List<Widget> _buildShowcaseActions() {
    return [
      Positioned(
        top: 51,
        left: 16,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              ShowCaseWidget.of(showCaseContext!).dismiss();

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
              ShowCaseWidget.of(showCaseContext!).next();
              if (ShowCaseWidget.of(showCaseContext!).activeWidgetId == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnimalInfoTutorialPage())
                );
              }
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
