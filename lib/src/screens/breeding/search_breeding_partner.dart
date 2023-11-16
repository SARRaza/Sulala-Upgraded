import 'package:flutter/material.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class SearchBreedingPartner extends StatefulWidget {
  const SearchBreedingPartner({super.key});

  @override
  State<SearchBreedingPartner> createState() => _SearchBreedingPartnerState();
}

class _SearchBreedingPartnerState extends State<SearchBreedingPartner> {
  List<Map<String, String>> breedPartnerDetails = [
    {'name': 'John', 'nickname': 'Cow', 'ID': 'xxxxxxxxx'},
    {'name': 'Mustang', 'nickname': 'Sheep', 'ID': '32f2133'},
    {'name': 'Bustefal', 'nickname': 'Horse', 'ID': '54fd34133'},
    {'name': 'Coleisum', 'nickname': 'Ox', 'ID': '3432333'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132df343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '32132343'},
    {'name': 'Emily', 'nickname': 'Rabbit', 'ID': '321df32343'},
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
            left: 16 * globals.widthMediaQuery,
            right: 16 * globals.widthMediaQuery,
            top: 16 * globals.heightMediaQuery,
            bottom: 16 * globals.heightMediaQuery),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40 * globals.heightMediaQuery,
                  width: 300 * globals.widthMediaQuery,
                  child: PrimarySearchBar(
                    hintText: 'Search By Name Or ID',
                    onChange: (value) {
                      setState(() {
                        breedPartnerDetails = [
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
                  height: 40 * globals.heightMediaQuery,
                  width: 40 * globals.widthMediaQuery,
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
              height: 24 * globals.heightMediaQuery,
            ),
            breedPartnerDetails.isEmpty
                ? Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                'assets/illustrations/cow_broke_adult.png'),
                            SizedBox(
                              height: 32 * globals.heightMediaQuery,
                            ),
                            Text(
                              'No Results',
                              style: AppFonts.headline3(
                                color: AppColors.grayscale90,
                              ),
                            ),
                            SizedBox(
                              height: 8 * globals.heightMediaQuery,
                            ),
                            Text(
                              'Do you want to create an animal?',
                              style: AppFonts.body2(
                                color: AppColors.grayscale70,
                              ),
                            ),
                            SizedBox(
                              height: 105 * globals.heightMediaQuery,
                            ),
                            SizedBox(
                              height: 52 * globals.heightMediaQuery,
                              width: 160 * globals.widthMediaQuery,
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
                      itemCount: breedPartnerDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 24 * globals.widthMediaQuery,
                            child: Text(breedPartnerDetails[index]['name']![0],
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90)),
                          ),
                          title: Text(
                            breedPartnerDetails[index]['name']!,
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          subtitle: Text(
                            breedPartnerDetails[index]['nickname']!,
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Text(
                            'ID #${breedPartnerDetails[index]['ID']}',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                          onTap: () {
                            Navigator.pop(
                                context, breedPartnerDetails[index]['name']);
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
