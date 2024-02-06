import 'package:flutter/material.dart';

import '../../data/globals.dart';

class AnimalListItem extends StatelessWidget {
  final Map<String, dynamic> mammal;
  final VoidCallback onTap;

  const AnimalListItem({
    Key? key,
    required this.mammal,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: SizeConfig.widthMultiplier(context) * 24,
        backgroundImage: AssetImage(mammal['image']),
      ),
      title: Text(mammal['name']),
      subtitle: Text(mammal['subtitle']),
      onTap: onTap,
    );
  }
}
