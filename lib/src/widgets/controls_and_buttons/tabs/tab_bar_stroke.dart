import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class TabBarStroke extends StatefulWidget {
  final List<String> tabTexts;
  final Function(int) onTabSelected;

  const TabBarStroke({
    super.key,
    required this.tabTexts,
    required this.onTabSelected,
  });

  @override
  State<TabBarStroke> createState() => _TabBarStrokeState();
}

class _TabBarStrokeState extends State<TabBarStroke> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 44,
      child: Row(
        children: List.generate(widget.tabTexts.length, (index) {
          final isActive = index == activeTabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeTabIndex = index;
                });
                widget.onTabSelected(activeTabIndex);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.tabTexts[index],
                    style: TextStyle(
                      color: isActive
                          ? AppColors.primary50
                          : AppColors.grayscale50,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  isActive
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 1,
                          color: AppColors.primary50,
                        )
                      : const SizedBox(height: 1),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}


// Example of use:
// TabBarStroke(
//           tabTexts: const ['Hi man', 'OK', 'yeah'],
//           onTabSelected: (index) {
//            print(index);},
//         ),
//
// You can Add as much text as you want