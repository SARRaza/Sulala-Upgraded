import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class TabBarFilled extends StatefulWidget {
  final List<String> tabTexts;
  final Function(int) onTabSelected;

  const TabBarFilled({
    super.key,
    required this.tabTexts,
    required this.onTabSelected,
  });

  @override
  State<TabBarFilled> createState() => _TabBarFilledState();
}

class _TabBarFilledState extends State<TabBarFilled> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.grayscale10,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: List.generate(widget.tabTexts.length, (index) {
          final isActive = index == activeTabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeTabIndex = index;
                });
                widget.onTabSelected(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary50 : AppColors.grayscale10,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    widget.tabTexts[index],
                    style: TextStyle(
                      color: isActive
                          ? AppColors.grayscale0
                          : AppColors.grayscale60,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}



// Example of use:
// TabBarFilled(
//           tabTexts: const ['Hi man', 'OK', 'yeah'],
//           onTabSelected: (index) {
//            print(index);},
//         ),
//
// You can Add as much text as you want