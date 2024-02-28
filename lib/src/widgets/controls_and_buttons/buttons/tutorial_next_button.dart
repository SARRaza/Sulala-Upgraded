import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialTextButton extends StatelessWidget {
  const TutorialTextButton({
    super.key,
    required this.showcaseKey,
    required this.description,
    required this.onTargetClick
  });

  final GlobalKey<State<StatefulWidget>> showcaseKey;
  final String description;
  final void Function()? onTargetClick;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showcaseKey,
      targetBorderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      description: description,
      descTextStyle: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 36, 86, 38),
          fontWeight: FontWeight.bold),
      onTargetClick: onTargetClick,
      disposeOnTap: true,
      child: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: onTargetClick,
          backgroundColor: Colors.white,
          elevation: 10,
          shape: const CircleBorder(),
          child: const SizedBox(
            width: 24,
            height: 24,
            child: Image(image: AssetImage(
                'assets/icons/frame/24px/24_Arrow_right.png'),),
          ),
        ),
      ),
    );
  }
}