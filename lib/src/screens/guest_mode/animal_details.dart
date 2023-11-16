import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';

class AnimalDetails extends StatefulWidget {
  final String imagePath;
  final String title;
  final String geninfo;

  const AnimalDetails({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.geninfo,
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
              width: globals.widthMediaQuery * 375,
              child: Image.asset(
                'assets/graphic/Animal_p.png',
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
                  topLeft: Radius.circular(globals.widthMediaQuery * 32),
                  topRight: Radius.circular(
                    (globals.widthMediaQuery * 32),
                  ),
                ),
              ),
              child: const SizedBox(),
            ),
          ),
          FractionalTranslation(
            translation: Offset(
              0,
              globals.heightMediaQuery * 0.18,
            ),
            child: SizedBox(
              height: globals.heightMediaQuery * 633,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: globals.widthMediaQuery * 60,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                  Text(
                    widget.title,
                    style: AppFonts.title4(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: globals.heightMediaQuery * 16,
                  ),
                  Row(
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
                  SizedBox(
                    height: globals.heightMediaQuery * 24,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: globals.widthMediaQuery * 16,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'General Information',
                                style: AppFonts.title5(
                                  color: AppColors.grayscale90,
                                ),
                              ),
                              SizedBox(
                                height: globals.heightMediaQuery * 14,
                              ),
                              Text(
                                widget.geninfo * 5,
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
        height: globals.heightMediaQuery * 52,
        width: globals.widthMediaQuery * 150,
        child: PrimaryButton(
          text: "Start your farm",
          onPressed: () {},
          status: PrimaryButtonStatus.idle,
          position: PrimaryButtonPosition.primary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
