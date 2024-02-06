import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../sign_up/join_now.dart';

class AnimalDetails extends StatefulWidget {
  final String imagePath;
  final String title;
  final String genInfo;
  final String animalType;
  final String animalDiet;

  const AnimalDetails({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.genInfo,
    required this.animalType,
    required this.animalDiet
  }) : super(key: key);

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
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
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: SizeConfig.widthMultiplier(context) * 375,
              child: Image.asset(
                'assets/graphic/Animal_p.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier(context) * 185,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(SizeConfig.widthMultiplier(context) * 32),
                  topRight: Radius.circular(
                    (SizeConfig.widthMultiplier(context) * 32),
                  ),
                ),
              ),
              child: const SizedBox(),
            ),
          ),
          FractionalTranslation(
            translation: Offset(
              0,
              SizeConfig.heightMultiplier(context) * 0.18,
            ),
            child: SizedBox(
              height: SizeConfig.heightMultiplier(context) * 633,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: SizeConfig.widthMultiplier(context) * 60,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                  Text(
                    widget.title,
                    style: AppFonts.title4(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 16,
                  ),
                  _buildAnimalTags(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 24,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier(context) * 16,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'General Information'.tr,
                                style: AppFonts.title5(
                                  color: AppColors.grayscale90,
                                ),
                              ),
                              SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 14,
                              ),
                              Text(
                                widget.genInfo * 5,
                                style: AppFonts.body2(
                                  color: AppColors.grayscale100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: SizeConfig.heightMultiplier(context) * 52,
        width: SizeConfig.widthMultiplier(context) * 150,
        child: PrimaryButton(
          text: "Start your farm".tr,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const JoinNow())),
          status: PrimaryButtonStatus.idle,
          position: PrimaryButtonPosition.primary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAnimalTags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTag(widget.animalType),
        SizedBox(width: SizeConfig.widthMultiplier(context) * 8),
        _buildTag(widget.animalDiet),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Tags(
      text: text,
      icon: null,
      onPress: () {
        // Handle tag click
      },
      status: TagStatus.active,
    );
  }

}
