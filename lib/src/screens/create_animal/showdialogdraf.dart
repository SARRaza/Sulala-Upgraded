import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

typedef TagStatusCallback = void Function(TagStatus status);

class ShowFilterUser extends StatefulWidget {
  final TagStatusCallback onBorrowesStatusChanged;
  final TagStatusCallback onAdoptedStatusChanged;
  final TagStatusCallback onDonatedStatusChanged;
  final TagStatusCallback onEscapedStatusChanged;
  final TagStatusCallback onStolenStatusChanged;
  final TagStatusCallback onTransferredStatusChanged;
  final TagStatusCallback onInjuredStatusChanged;
  final TagStatusCallback onSickStatusChanged;
  final TagStatusCallback onQuarantinedStatusChanged;
  final TagStatusCallback onMedicationStatusChanged;
  final TagStatusCallback onTestingStatusChanged;
  final TagStatusCallback onSoldStatusChanged;
  final TagStatusCallback onDeadStatusChanged;
  final TagStatus initialBorrowedStatus;
  final TagStatus initialAdoptedStatus;
  final TagStatus initialDonatedStatus;
  final TagStatus initialEscapedStatus;
  final TagStatus initialStolenStatus;
  final TagStatus initialTransferredStatus;
  final TagStatus initialInjuredStatus;
  final TagStatus initialSickStatus;
  final TagStatus initialQuarantinedStatus;
  final TagStatus initialMedicationStatus;
  final TagStatus initialTestingStatus;
  final TagStatus initialSoldStatus;
  final TagStatus initialDeadStatus;

  const ShowFilterUser({
    super.key,
    required this.onBorrowesStatusChanged,
    required this.onAdoptedStatusChanged,
    required this.onDonatedStatusChanged,
    required this.onEscapedStatusChanged,
    required this.onStolenStatusChanged,
    required this.onTransferredStatusChanged,
    required this.onInjuredStatusChanged,
    required this.onSickStatusChanged,
    required this.onQuarantinedStatusChanged,
    required this.onMedicationStatusChanged,
    required this.onTestingStatusChanged,
    required this.onSoldStatusChanged,
    required this.onDeadStatusChanged,
    required this.initialBorrowedStatus,
    required this.initialAdoptedStatus,
    required this.initialDonatedStatus,
    required this.initialEscapedStatus,
    required this.initialStolenStatus,
    required this.initialTransferredStatus,
    required this.initialInjuredStatus,
    required this.initialSickStatus,
    required this.initialQuarantinedStatus,
    required this.initialMedicationStatus,
    required this.initialTestingStatus,
    required this.initialSoldStatus,
    required this.initialDeadStatus,
  });

  @override
  State<ShowFilterUser> createState() => _ShowFilterUserState();
}

class _ShowFilterUserState extends State<ShowFilterUser> {
  late TagStatus borrowed;
  late TagStatus adopted;
  late TagStatus donated;
  late TagStatus escaped;
  late TagStatus stolen;
  late TagStatus transferred;
  late TagStatus injured;
  late TagStatus sick;
  late TagStatus quarantined;
  late TagStatus medication;
  late TagStatus testing;
  late TagStatus sold;
  late TagStatus dead;

  @override
  void initState() {
    super.initState();
    borrowed = widget.initialBorrowedStatus;
    adopted = widget.initialAdoptedStatus;
    donated = widget.initialDonatedStatus;
    escaped = widget.initialEscapedStatus;
    stolen = widget.initialStolenStatus;
    transferred = widget.initialTransferredStatus;
    injured = widget.initialInjuredStatus;
    sick = widget.initialSickStatus;
    quarantined = widget.initialQuarantinedStatus;
    medication = widget.initialMedicationStatus;
    testing = widget.initialTestingStatus;
    sold = widget.initialSoldStatus;
    dead = widget.initialDeadStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: globals.heightMediaQuery * 20,
        ),
        Text(
          'Current State',
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tags(
              text: "Borrowed",
              onPress: () {
                final newStatus = borrowed == TagStatus.active
                    ? TagStatus.notActive
                    : TagStatus.active;

                setState(() {
                  borrowed = newStatus;
                });

                widget.onBorrowesStatusChanged(newStatus);
              },
              status: borrowed, // Use the current borrowed status
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Adopted',
              onPress: () {
                final newStatus = adopted == TagStatus.active
                    ? adopted = TagStatus.notActive
                    : adopted = TagStatus.active;

                setState(() {
                  adopted = newStatus;
                });

                widget.onAdoptedStatusChanged(newStatus);
              },
              status: adopted,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Donated',
              onPress: () {
                final newStatus = donated == TagStatus.active
                    ? donated = TagStatus.notActive
                    : donated = TagStatus.active;
                setState(() {
                  donated = newStatus;
                });
                widget.onDonatedStatusChanged(newStatus);
              },
              status: donated,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tags(
              text: 'Escaped',
              onPress: () {
                final newStatus = escaped == TagStatus.active
                    ? escaped = TagStatus.notActive
                    : escaped = TagStatus.active;
                setState(() {
                  escaped = newStatus;
                });
                widget.onEscapedStatusChanged(newStatus);
              },
              status: escaped,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Stolen',
              onPress: () {
                final newStatus = stolen == TagStatus.active
                    ? stolen = TagStatus.notActive
                    : stolen = TagStatus.active;
                setState(() {
                  stolen = newStatus;
                });
                widget.onStolenStatusChanged(newStatus);
              },
              status: stolen,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Transferred',
              onPress: () {
                final newStatus = transferred == TagStatus.active
                    ? transferred = TagStatus.notActive
                    : transferred = TagStatus.active;

                setState(() {
                  transferred = newStatus;
                });

                widget.onTransferredStatusChanged(newStatus);
              },
              status: transferred,
            ),
          ],
        ),
        SizedBox(
          height: globals.heightMediaQuery * 24,
        ),
        Text('Medical State',
            style: AppFonts.headline3(color: AppColors.grayscale90)),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tags(
              text: 'Injured',
              onPress: () {
                final newStatus = injured == TagStatus.active
                    ? injured = TagStatus.notActive
                    : injured = TagStatus.active;
                setState(() {
                  injured = newStatus;
                });

                widget.onInjuredStatusChanged(newStatus);
              },
              status: injured,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Sick',
              onPress: () {
                final newStatus = sick == TagStatus.active
                    ? sick = TagStatus.notActive
                    : sick = TagStatus.active;

                setState(() {
                  sick = newStatus;
                });

                widget.onSickStatusChanged(newStatus);
              },
              status: sick,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Quarantined',
              onPress: () {
                final newStatus = quarantined == TagStatus.active
                    ? quarantined = TagStatus.notActive
                    : quarantined = TagStatus.active;

                setState(() {
                  quarantined = newStatus;
                });

                widget.onQuarantinedStatusChanged(newStatus);
              },
              status: quarantined,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tags(
              text: 'Medication',
              onPress: () {
                final newStatus = medication == TagStatus.active
                    ? medication = TagStatus.notActive
                    : medication = TagStatus.active;
                setState(() {
                  medication = newStatus;
                });

                widget.onMedicationStatusChanged(newStatus);
              },
              status: medication,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Testing',
              onPress: () {
                final newStatus = testing == TagStatus.active
                    ? testing = TagStatus.notActive
                    : testing = TagStatus.active;

                setState(() {
                  testing = newStatus;
                });

                widget.onTestingStatusChanged(newStatus);
              },
              status: testing,
            ),
          ],
        ),
        SizedBox(
          height: globals.heightMediaQuery * 24,
        ),
        Text(
          'Others',
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tags(
              text: 'Sold',
              onPress: () {
                final newStatus = sold == TagStatus.active
                    ? sold = TagStatus.notActive
                    : sold = TagStatus.active;

                setState(() {
                  sold = newStatus;
                });

                widget.onSoldStatusChanged(newStatus);
              },
              status: sold,
            ),
            SizedBox(width: globals.widthMediaQuery * 8),
            Tags(
              text: 'Dead',
              onPress: () {
                final newStatus = dead == TagStatus.active
                    ? dead = TagStatus.notActive
                    : dead = TagStatus.active;

                setState(() {
                  dead = newStatus;
                });

                widget.onDeadStatusChanged(newStatus);
              },
              status: dead,
            ),
          ],
        ),
        SizedBox(
          height: globals.heightMediaQuery * 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: globals.heightMediaQuery * 52,
              width: globals.widthMediaQuery * 165,
              child: SecondaryButton(
                onPressed: () {
                  setState(() {
                    widget.onBorrowesStatusChanged(
                        borrowed = TagStatus.notActive);
                    widget
                        .onAdoptedStatusChanged(adopted = TagStatus.notActive);
                    widget
                        .onDonatedStatusChanged(donated = TagStatus.notActive);
                    widget
                        .onEscapedStatusChanged(escaped = TagStatus.notActive);
                    widget.onStolenStatusChanged(stolen = TagStatus.notActive);
                    widget.onTransferredStatusChanged(
                        transferred = TagStatus.notActive);
                    widget
                        .onInjuredStatusChanged(injured = TagStatus.notActive);

                    widget.onSickStatusChanged(sick = TagStatus.notActive);
                    widget.onQuarantinedStatusChanged(
                        quarantined = TagStatus.notActive);
                    widget.onMedicationStatusChanged(
                        medication = TagStatus.notActive);
                    widget
                        .onTestingStatusChanged(testing = TagStatus.notActive);
                    widget.onSoldStatusChanged(sold = TagStatus.notActive);
                    widget.onDeadStatusChanged(dead = TagStatus.notActive);
                  });
                  Navigator.pop(context);
                },
                text: 'Clear All',
                status: SecondaryButtonStatus.idle,
              ),
            ),
            SizedBox(
              height: globals.heightMediaQuery * 52,
              width: globals.widthMediaQuery * 165,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Apply',
                status: PrimaryButtonStatus.idle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
