import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

import '../../../data/countries_data.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../inputs/search_bars/search_bar.dart';

class CountriesWidget extends ConsumerStatefulWidget {
  const CountriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CountriesWidget> createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends ConsumerState<CountriesWidget> {
  List<CountryInfo> filteredCountries = countriesData;
  String searchQuery = "";

  void _filterCountries(String query) {
    setState(() {
      searchQuery = query;
      filteredCountries = countriesData
          .where((country) =>
              country.countryName.toLowerCase().contains(query.toLowerCase()) ||
              country.countryCode.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showNotFoundText =
        searchQuery.isNotEmpty && filteredCountries.isEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimarySearchBar(
            hintText: 'Search for a country',
            onChange: _filterCountries,
          ),
        ),
        if (showNotFoundText)
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Country not found!",
              style: AppFonts.headline2(color: AppColors.grayscale90),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(filteredCountries[index].flagImagePath),
                title: Text(filteredCountries[index].countryName),
                subtitle: Text(filteredCountries[index].countryCode),
                onTap: () {
                  ref
                      .read(selectedCountryCodeProvider.notifier)
                      .update((state) => filteredCountries[index].countryCode);

                  ref.read(selectedCountryFlagProvider.notifier).update(
                      (state) => filteredCountries[index].flagImagePath);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

typedef CountrySelectionCallback = void Function(CountryInfo countryInfo);

// Example of use: 


//Functions to be added to the class:
// void _onCountrySelected(CountryInfo countryInfo) {
//     setState(
//       () {
//         selectedCountry = countryInfo;
//         countryCode = countryInfo.countryCode;
//         countryFlag = countryInfo.flagImagePath;
//         print(countryInfo.countryName);
//       },
//     );
//     Navigator.pop(context);
//   }



// SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.95,
//                   child: CountriesWidget(
//                     onCountrySelected: _onCountrySelected,
//                   ),
//                 ),