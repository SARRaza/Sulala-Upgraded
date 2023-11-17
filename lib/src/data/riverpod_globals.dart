import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Join Now Global Variables
final whoOwnTheFarmProvider = StateProvider<String>((ref) => '');
final whatIsTheNameOfYourFarmProvider = StateProvider<String>((ref) => '');
final hasErrorProvider = StateProvider<bool>((ref) => false);

// Sign Up Global Variables

final selectedCountryCodeProvider = StateProvider<String>((ref) => "+966");
final selectedCountryFlagProvider =
    StateProvider<String>((ref) => "assets/icons/flags/Country=SA.png");
final phoneNumberProvider = StateProvider<String>((ref) => '');
final emailAdressProvider = StateProvider<String>((ref) => '');

// Create Password Global Variables

final passwordProvider = StateProvider<String>((ref) => '');
final passwrodConfirmProvider = StateProvider<String>((ref) => '');

// Add Personal Information Gloabl Varibales

final firstNameProvider = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');

// Add Some Details Global Variables
final cityProvider = StateProvider<String>((ref) => '');
final countryProvider = StateProvider<String>((ref) => '');
final proflePictureProvider = StateProvider<File?>((ref) => null);

// Privacy & Security Global Variables
final emailAddressVisibilityProvider = StateProvider<bool>((ref) => false);
final phoneNumberVisibilityProvider = StateProvider<bool>((ref) => false);
