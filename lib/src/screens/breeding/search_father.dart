import 'package:flutter/material.dart';

import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class SearchFather extends StatefulWidget {
  const SearchFather({super.key});

  @override
  State<SearchFather> createState() => _SearchFatherState();
}

class _SearchFatherState extends State<SearchFather> {
  List<Map<String, String>> breedFatherDetails = [
    {'name': 'John', 'nickname': 'Cow', 'ID': '122123'},
    {'name': 'Mustang', 'nickname': 'Sheep', 'ID': '3212133'},
    {'name': 'Bustefal', 'nickname': 'Horse', 'ID': '5434133'},
    {'name': 'Coleisum', 'nickname': 'Ox', 'ID': '3432333'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(
            left: 16 * SizeConfig.widthMultiplier(context),
            right: 16 * SizeConfig.widthMultiplier(context),
            top: 16 * SizeConfig.heightMultiplier(context),
            bottom: 16 * SizeConfig.heightMultiplier(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40 * SizeConfig.heightMultiplier(context),
                  width: 300 * SizeConfig.widthMultiplier(context),
                  child: PrimarySearchBar(
                    hintText: 'Search By Name Or ID',
                    onChange: (value) {
                      setState(() {
                        breedFatherDetails = [
                          {'name': 'John', 'nickname': 'Cow', 'ID': '122123'},
                          {
                            'name': 'Mustang',
                            'nickname': 'Sheep',
                            'ID': '3212133'
                          },
                          {
                            'name': 'Bustefal',
                            'nickname': 'Horse',
                            'ID': '5434133'
                          },
                          {
                            'name': 'Coleisum',
                            'nickname': 'Ox',
                            'ID': '3432333'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                          {
                            'name': 'Emily',
                            'nickname': 'Rabbit',
                            'ID': '32132343'
                          },
                        ]
                            .where((entry) =>
                                entry['name']!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                entry['nickname']!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                // I want a X button
                Container(
                  height: 40 * SizeConfig.heightMultiplier(context),
                  width: 40 * SizeConfig.widthMultiplier(context),
                  decoration: const BoxDecoration(
                    color: AppColors.grayscale10,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24 * SizeConfig.heightMultiplier(context),
            ),
            breedFatherDetails.isEmpty
                ? Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/illustrations/cowx_child.png'),
                            SizedBox(
                              height: 32 * SizeConfig.heightMultiplier(context),
                            ),
                            Text(
                              'No Results',
                              style: AppFonts.headline3(
                                color: AppColors.grayscale90,
                              ),
                            ),
                            SizedBox(
                              height: 8 * SizeConfig.heightMultiplier(context),
                            ),
                            Text(
                              'Do you want to create an animal?',
                              style: AppFonts.body2(
                                color: AppColors.grayscale70,
                              ),
                            ),
                            SizedBox(
                              height:
                                  105 * SizeConfig.heightMultiplier(context),
                            ),
                            SizedBox(
                              height: 52 * SizeConfig.heightMultiplier(context),
                              width: 160 * SizeConfig.widthMultiplier(context),
                              child: PrimaryButton(
                                text: 'Create Animal',
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: breedFatherDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 24 * SizeConfig.widthMultiplier(context),
                            child: Text(breedFatherDetails[index]['name']![0],
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90)),
                          ),
                          title: Text(
                            breedFatherDetails[index]['name']!,
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          subtitle: Text(
                            breedFatherDetails[index]['nickname']!,
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Text(
                            'ID #${breedFatherDetails[index]['ID']}',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                          onTap: () {
                            Navigator.pop(
                                context, breedFatherDetails[index]['name']);
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
