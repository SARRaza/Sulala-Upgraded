import 'package:flutter/material.dart';

class SmallCardWidget extends StatelessWidget {
  final Image icon;
  final String quantity;
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color? backgroundColor;

  const SmallCardWidget({
    Key? key,
    required this.icon,
    required this.quantity,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isSelected
        ? const Color.fromRGBO(225, 219, 190, 1)
        : backgroundColor ?? const Color.fromRGBO(249, 245, 236, 1);

    return Material(
      type: MaterialType.card,
      color: cardColor,
      borderRadius: BorderRadius.circular(8.0), // Example border radius
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 3),
              Text(quantity, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
