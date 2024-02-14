import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/providers/animal_list_provider.dart';
import 'package:sulala_upgrade/src/data/providers/breeding_event_list_provider.dart';
import 'package:sulala_upgrade/src/data/providers/medical_checkup_list_provider.dart';
import 'package:sulala_upgrade/src/data/providers/surgery_list_provider.dart';
import 'package:sulala_upgrade/src/data/providers/vaccination_list_provider.dart';
import 'package:sulala_upgrade/src/screens/pdf/file_view_page.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:sulala_upgrade/src/widgets/inputs/draw_ups/draw_up_widget.dart';
import 'package:sulala_upgrade/src/widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/eggs_number_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/medical_needs_paragraph.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import '../pdf/pdf_view_page.dart';
import 'add_medical_checkup.dart';
import 'add_surgeries.dart';
import 'add_vaccination.dart';
import 'edit_medical_checkup.dart';
import 'edit_surgeries.dart';
import 'edit_vaccination.dart';

import 'pregnant_status_draw_up.dart';

class MammalsMedical extends ConsumerStatefulWidget {
  final OviVariables animal;
  const MammalsMedical(
      {super.key,
      required this.animal});

  @override
  ConsumerState<MammalsMedical> createState() => _MammalsMedicalState();
}

class _MammalsMedicalState extends ConsumerState<MammalsMedical> {
  bool isMammalEditMode = false;
  late final TextEditingController _medicalNeedsController;
  late final TextEditingController _pregnanciesCountController;
  final _pregnanciesCountFormKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _medicalNeedsController = TextEditingController(text: widget.animal.medicalNeeds);
    _pregnanciesCountController = TextEditingController(text: widget.animal.pregnanciesCount?.toString() ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().copyWith(hour: 0, minute: 0,
        second: 0, millisecond: 0, microsecond: 0);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(vaccinationListProvider(widget.animal.id!)).when(
                error: (error, trace) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
                data: (vaccinations) {
                  final futureVaccinationDates = vaccinations.map(
                          (vaccination) => vaccination.secondDoseDate).where(
                          (date) => date?.isAfter(today
                          ) == true || date?.isAtSameMomentAs(
                              today) == true).toList();
                  futureVaccinationDates.sort(
                          (date1, date2) => date1!.compareTo(date2!));
                  final DateTime? nextVaccinationDate = futureVaccinationDates.firstOrNull;

                  return SizedBox(
                    width: SizeConfig.widthMultiplier(context) * 343,
                    child: OneInformationBlock(
                        head1: nextVaccinationDate != null
                            ? DateFormat('dd.MM.yyyy').format(nextVaccinationDate)
                            : 'N/A',
                        subtitle1: 'Next Vaccination'.tr),
                  );
                }
              );
            }
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier(context) * 8,
          ),
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(medicalCheckupListProvider(widget.animal.id!)).when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                data: (checkups) {
                    final pastCheckupDates = checkups.map(
                            (checkup) => checkup.firstCheckUp).where((date) => date?.isBefore(today) == true).toList();
                    pastCheckupDates.sort((date1, date2) => date1!.compareTo(date2!));
                    final lastCheckupDate = pastCheckupDates.lastOrNull;
              
                    final futureCheckupDates = checkups.map((checkup) => checkup.secondCheckUp).where(
                            (date) => date?.isAfter(today
                        ) == true || date?.isAtSameMomentAs(
                            today) == true).toList();
                    futureCheckupDates.sort(
                            (date1, date2) => date1!.compareTo(date2!));
                    final DateTime? nextCheckupDate = futureCheckupDates.firstOrNull;
                    
                  return SizedBox(
                    width: 343 * SizeConfig.widthMultiplier(context),
                    child: TwoInformationBlock(
                      head1: lastCheckupDate != null
                          ? DateFormat('dd.MM.yyyy').format(lastCheckupDate)
                          : 'N/A',
                      head2: nextCheckupDate != null
                          ? DateFormat('dd.MM.yyyy').format(nextCheckupDate)
                          : 'N/A',
                      subtitle1: "Last Check-up Date".tr,
                      subtitle2: "Next Check-up Date".tr,
                    ),
                  );
                }
              );
            }
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier(context) * 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical Needs'.tr,
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              isMammalEditMode
                  ? PrimaryTextButton(
                      status: TextStatus.idle,
                      text: 'Save'.tr,
                      onPressed: () async {
                        isMammalEditMode = false;
                        final animal = ref.read(animalListProvider).requireValue
                            .firstWhere((animal) => animal.id == widget.animal
                            .id);
                        ref.read(animalListProvider.notifier).updateAnimal(
                            animal.copyWith(
                                medicalNeeds: _medicalNeedsController.text));
                      })
                  : IconButton(
                      icon: Image.asset(
                        'assets/icons/frame/24px/24_Edit.png',
                      ),
                      onPressed: () {
                        // Enter edit mode
                        setState(() {
                          isMammalEditMode = true;
                        });
                      },
                    ),
            ],
          ),
          isMammalEditMode
              ? Column(
                  children: [
                    SizedBox(
                      child: MedicalNeedsParagraphTextField(
                        maxLines: 6,
                        hintText:
                            'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                        controller: _medicalNeedsController,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 8,
                    ),
                    FileUploaderField(
                      onFileUploaded: (file) {
                        final animal = ref.read(animalListProvider).requireValue
                            .firstWhere((animal) => animal.id == widget.animal.id);
                        final files = animal.files ?? [];
                        files.add(file);
                        ref.read(animalListProvider.notifier).updateAnimal(
                            animal.copyWith(files: files));
                      },
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.animal.medicalNeeds
                                ?.isNotEmpty !=
                            null
                        ? Text(
                            widget.animal.medicalNeeds!,
                            // 'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          )
                        : Text(
                            'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 22,
                    ),
                    if (widget.animal.files != null)
                      Column(
                        children: widget.animal.files!
                            .map((file) => GestureDetector(
                                  onTap: () => _showFile(file),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.file_copy_outlined,
                                        color: AppColors.primary30,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          file.path.split('/').last,
                                          style: AppFonts.body1(
                                              color: AppColors.grayscale90),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                  ],
                ),
          SizedBox(
            height: 16 * SizeConfig.heightMultiplier(context),
          ),
          Visibility(
            visible: widget.animal.selectedOviGender == 'Female' &&
                widget.animal.selectedAnimalType == 'Mammal',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pregnancy Check',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Count of Pregnancies',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _showPregnanciesCountModal(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.animal.pregnanciesCount ?? 0}',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _showPregnantStatusSelection(
                        context, widget.animal.pregnant ?? false);
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Pregnancy status'.tr,
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.animal.pregnant == true
                            ? 'Pregnant'.tr
                            : 'Not Pregnant'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.primary40),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(breedingEventListProvider(widget.animal.id!)).when(
                      error: (error, trace) => Text('Error: $error'),
                      loading: () => const CircularProgressIndicator(),
                      data: (events) {
                        final lastEvent = events.lastOrNull;
                        if(lastEvent == null) {
                          return Container();
                        }

                        return ListTile(
                          onTap: () {
                            _showMatingDatePickerModalSheet(lastEvent);
                          },
                          contentPadding: const EdgeInsets.only(right: 0, left: 0),
                          leading: Text(
                            'Date of Mating',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                lastEvent.breedingDate != null
                                    ? DateFormat('dd.MM.yyyy').format(lastEvent.breedingDate!)
                                    : 'N/A',
                                style: AppFonts.body2(color: AppColors.grayscale90),
                              ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.primary40),
                            ],
                          ),
                        );
                      }
                    );
                  }
                ),
                ListTile(
                  onTap: () {
                    _dateOfSonarDatePickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Date of sonar',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.animal.dateOfSonar != null
                          ? Text(
                              DateFormat('dd/MM/yyyy').format(widget.animal.dateOfSonar!),
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            )
                          : Text(
                              'ADD',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            ),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.primary40),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(breedingEventListProvider(widget.animal.id!)).when(
                      error: (error, trace) => Text('Error: $error'),
                      loading: () => const CircularProgressIndicator(),
                      data: (events) {
                        final deliveryDate = events.lastOrNull?.deliveryDate;
                        return ListTile(
                          onTap: () {
                            _showExpDeliveryDatePickerModalSheet();
                          },
                          contentPadding: const EdgeInsets.only(right: 0, left: 0),
                          leading: Text(
                            'Exp. Delivery Date',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              deliveryDate != null
                                  ? Text(
                                      DateFormat('dd/MM/yyyy').format(deliveryDate),
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    )
                                  : Text(
                                      'ADD',
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.primary40),
                            ],
                          ),
                        );
                      }
                    );
                  }
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(breedingEventListProvider(widget.animal.id!)).when(
                error: (error, trace) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
                data: (events) {
                  final lastEvent = events.lastOrNull;
                  return Visibility(
                    visible: widget.animal.selectedOviGender == 'Female' &&
                        widget.animal.selectedAnimalType == 'Oviparous' &&
                        lastEvent != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hatching Information',
                          style: AppFonts.title5(color: AppColors.grayscale90),
                        ),
                        ListTile(
                          onTap: () {
                            _dateOfLayingEggsPickerModalSheet(lastEvent!);
                          },
                          contentPadding: const EdgeInsets.only(right: 0, left: 0),
                          leading: Text(
                            'Date Of Laying Eggs',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              lastEvent?.layingEggsDate != null
                                  ? Text(
                                      DateFormat('dd/MM/yyyy').format(lastEvent!.layingEggsDate!),
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    )
                                  : Text(
                                      'ADD',
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.primary40),
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _showNumOfEggsModal(lastEvent!);
                          },
                          contentPadding: const EdgeInsets.only(right: 0, left: 0),
                          leading: Text(
                            'Number Of Eggs',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              lastEvent?.eggsNumber != null
                                  ? Text(
                                      lastEvent!.eventNumber,
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    )
                                  : Text(
                                      'ADD',
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.primary40),
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _showKeptInOvalSelection(context);
                          },
                          contentPadding: const EdgeInsets.only(right: 0, left: 0),
                          leading: Text(
                            'Have You Kept Eggs In Oval?'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.animal.keptInOval.isNotEmpty
                                  ? Text(
                                widget.animal.keptInOval == 'No' ? 'No'.tr : 'Yes'.tr,
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    )
                                  : Text(
                                      'ADD',
                                      style:
                                          AppFonts.body2(color: AppColors.grayscale90),
                                    ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.primary40),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.animal.keptInOval != 'No',
                          child: ListTile(
                            onTap: () {
                              _incubationDatePickerModalSheet(lastEvent!);
                            },
                            contentPadding: const EdgeInsets.only(right: 0, left: 0),
                            leading: Text(
                              'Incubation Date',
                              style: AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                lastEvent?.incubationDate != null
                                    ? Text(
                                        DateFormat('dd/MM/yyyy').format(lastEvent!.incubationDate!),
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale90),
                                      )
                                    : Text(
                                        'ADD',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale90),
                                      ),
                                const Icon(Icons.chevron_right_rounded,
                                    color: AppColors.primary40),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                      ],
                    ),
                  );
                }
              );
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vaccination',
                style: AppFonts.title5(color: AppColors.grayscale90),
              )
            ],
          ),
          SizedBox(
            height: 14 * SizeConfig.heightMultiplier(context),
          ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(vaccinationListProvider(widget.animal.id!)).when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                  data: (vaccinations) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vaccinations.length,
                      shrinkWrap:
                          true, // This allows the ListView to take only necessary space
                      itemBuilder: (BuildContext context, int index) {
                        return StyledDismissible(
                          confirmDismiss: _confirmDeletion,
                          onDismissed: (direction) {
                            ref.read(vaccinationListProvider(widget.animal.id!)
                                .notifier).removeVaccination(vaccinations[index].id!
                            );
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              vaccinations[index].vaccineName,
                              style: AppFonts.headline3(color: AppColors.grayscale90),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (vaccinations[index].files != null &&
                                    vaccinations[index].files!.isNotEmpty)
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FileViewPage(
                                                  files: vaccinations[index]
                                                      .files!)));
                                    },
                                    icon: const Icon(
                                      Icons.file_copy_outlined,
                                      color: AppColors.primary40,
                                    ),
                                  ),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.primary40,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditVaccination(
                                    animalId: widget.animal.id!,
                                    vaccinationId: vaccinations[index].id!,
                                  ),
                                ),
                              );
                            },
                            subtitle: vaccinations[index].firstDoseDate != null ||
                                vaccinations[index].secondDoseDate != null
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vaccinations[index].firstDoseDate != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                            vaccinations[index]
                                                    .firstDoseDate!)
                                            : '',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                      Text(
                                        vaccinations[index].secondDoseDate != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                            vaccinations[index]
                                                    .secondDoseDate!)
                                            : '',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        );
                      },
                    );
                  }
                );
              }
            ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVaccination(animalId: widget
                          .animal.id!,),
                    ),
                  );
                  setState(() {});
                },
                text: 'Add Vaccination',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * SizeConfig.widthMultiplier(context),
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * SizeConfig.widthMultiplier(context),
              ),
            ],
          ),
          SizedBox(
            height: 16 * SizeConfig.heightMultiplier(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical Checkup',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              // PrimaryTextButton(
              //   onPressed: () {},
              //   status: TextStatus.idle,
              //   text: 'View More',
              // ),
            ],
          ),
          SizedBox(
            height: 14 * SizeConfig.heightMultiplier(context),
          ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(medicalCheckupListProvider(widget.animal.id!))
                    .when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                  data: (checkups) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: checkups.length,
                      shrinkWrap:
                          true, // This allows the ListView to take only necessary space
                      itemBuilder: (BuildContext context, int index) {
                        return StyledDismissible(
                          confirmDismiss: _confirmDeletion,
                          onDismissed: (direction) {
                            ref.read(medicalCheckupListProvider(widget.animal.id!).notifier).removeCheckup(checkups[index].id!);
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              checkups[index].checkupName,
                              style: AppFonts.headline3(color: AppColors.grayscale90),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (checkups[index].files != null &&
                                    checkups[index].files!.isNotEmpty)
                                  IconButton(
                                    onPressed: () =>
                                        _showFiles(checkups[index].files!),
                                    icon: const Icon(
                                      Icons.file_copy_outlined,
                                      color: AppColors.primary40,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMedicalCheckUp(
                                        checkUpId: checkups[index].id!,
                                        animalId: widget.animal.id!,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.primary40,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: checkups[index].firstCheckUp != null ||
                                checkups[index].secondCheckUp != null
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        checkups[index].firstCheckUp != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                            checkups[index].firstCheckUp!)
                                            : '',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                      Text(
                                        checkups[index].secondCheckUp != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                            checkups[index]
                                                    .secondCheckUp!)
                                            : '',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        );
                      },
                    );
                  }
                );
              }
            ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedicalCheckUp(animalId: widget.animal.id!,),
                    ),
                  );
                },
                text: 'Add Examination Results',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * SizeConfig.widthMultiplier(context),
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * SizeConfig.widthMultiplier(context),
              ),
            ],
          ),
          SizedBox(
            height: 16 * SizeConfig.heightMultiplier(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Surgeries Records',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              // PrimaryTextButton(
              //   onPressed: () {},
              //   status: TextStatus.idle,
              //   text: 'View More',
              // ),
            ],
          ),
          SizedBox(
            height: 14 * SizeConfig.heightMultiplier(context),
          ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(surgeryListProvider(widget.animal.id!)).when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                  data: (surgeries) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: surgeries.length,
                      shrinkWrap:
                          true, // This allows the ListView to take only necessary space
                      itemBuilder: (BuildContext context, int index) {
                        return StyledDismissible(
                          confirmDismiss: _confirmDeletion,
                          onDismissed: (direction) {
                            ref.read(surgeryListProvider(widget.animal.id!).notifier).removeSurgery(surgeries[index].id!);
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              surgeries[index].surgeryName,
                              style: AppFonts.headline3(color: AppColors.grayscale90),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (surgeries[index].files != null &&
                                    surgeries[index].files!.isNotEmpty)
                                  IconButton(
                                    onPressed: () =>
                                        _showFiles(surgeries[index].files!),
                                    icon: const Icon(
                                      Icons.file_copy_outlined,
                                      color: AppColors.primary40,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditSurgeriesRecords(
                                          surgeryId: surgeries[index].id!,
                                          animalId: widget.animal.id!,
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.primary40,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: surgeries[index].firstSurgery != null ||
                                surgeries[index].secondSurgery != null
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                            surgeries[index].firstSurgery ??
                                                DateTime.now()),
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                            surgeries[index].secondSurgery ??
                                                DateTime.now()),
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        );
                      },
                    );
                  }
                );
              }
            ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSurgeriesRecords(
                        animalId: widget.animal.id!,
                      ),
                    ),
                  );
                },
                text: 'Add Surgeries Records',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * SizeConfig.widthMultiplier(context),
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * SizeConfig.widthMultiplier(context),
              ),
            ],
          ),
          SizedBox(
            height: 24 * SizeConfig.heightMultiplier(context),
          ),
        ],
      ),
    );
  }

  void _showExpDeliveryDatePickerModalSheet() async {
    final DateTime? expDeliveryDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );

    if (expDeliveryDate != null) {
      ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(expDlvDate: expDeliveryDate));
    }
  }

  void _dateOfSonarDatePickerModalSheet() async {
    final DateTime? dateOfSonar = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );

    if (dateOfSonar != null) {
      ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(dateOfSonar: dateOfSonar));
    }
  }

  void _dateOfLayingEggsPickerModalSheet(BreedingEventVariables event) async {
    final DateTime? dateOfLayingEggs = await showDatePicker(
      context: context,
      initialDate: event.layingEggsDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );
    ref.read(breedingEventListProvider(widget.animal.id!).notifier).updateEvent(
        event.copyWith(layingEggsDate: dateOfLayingEggs));
      
  }

  void _incubationDatePickerModalSheet(BreedingEventVariables event) async {
    final DateTime? incubationDate = await showDatePicker(
      context: context,
      initialDate: event.incubationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );

    if (incubationDate != null) {
        ref.read(breedingEventListProvider(widget.animal.id!).notifier)
            .updateEvent(event.copyWith(incubationDate: incubationDate));
    }
  }

  Future<void> _showNumOfEggsModal(BreedingEventVariables event) async {
    final newEggsNumber = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return EggsNumberModal(
          eggsNumber: event.eggsNumber ?? 0,
        );
      },
    );
    if(newEggsNumber != null) {
      ref.read(breedingEventListProvider(widget.animal.id!).notifier)
          .updateEvent(event.copyWith(eggsNumber: newEggsNumber));
    }
    
  }

  void _showKeptInOvalSelection(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Have You Kept In Oval?',
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier(context) * 12,
                    bottom: SizeConfig.heightMultiplier(context) * 12),
                child: GestureDetector(
                  onTap: () {
                    const keptInOval = 'Yes, Kept In Oval';
                    ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(keptInOval: keptInOval));
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Yes, Kept In Oval',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier(context) * 24,
                        height: SizeConfig.widthMultiplier(context) * 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.animal.keptInOval == 'Yes, Kept In Oval'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: widget.animal.keptInOval == 'Yes, Kept In Oval' ? 6.0 : 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier(context) * 12,
                    bottom: SizeConfig.heightMultiplier(context) * 12),
                child: GestureDetector(
                  onTap: () {
                    const keptInOval = 'No';
                    ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(keptInOval: keptInOval));
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'No',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier(context) * 24,
                        height: SizeConfig.widthMultiplier(context) * 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.animal.keptInOval == 'No'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: widget.animal.keptInOval == 'No' ? 6.0 : 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 55 * SizeConfig.heightMultiplier(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPregnantStatusSelection(
      BuildContext context, bool currentPregnantStatus) {
    showModalBottomSheet<bool>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return PregnantStatusWidget(
          mammalPregnantStatus: currentPregnantStatus,
        );
      },
    ).then((newStatus) {
      if (currentPregnantStatus == false && newStatus == true) {
        ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(pregnant: true, pregnanciesCount: widget.animal.pregnanciesCount ?? 0 + 1));
      } else {
        ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(pregnant: true));
      }
    });
  }

  Future<void> _showFile(File file) async {
    final fileName = file.path.split('/').last;
    if (mounted) {
      if (fileName.endsWith('.pdf')) {
        // Open PDF
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
        );
      } else {
        // Open Image in a new screen or dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.file(file),
          ),
        );
      }
    }
  }


  _showFiles(List<File> files) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FileViewPage(files: files)));
  }

  Future<void> _showPregnanciesCountModal() async {
    final newCount = await showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: DrawUpWidget(
              heightFactor: 0.5,
              heading: 'Pregnancies count',
              content: Form(
                key: _pregnanciesCountFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        PrimaryTextField(
                          keyboardType: TextInputType.number,
                          hintText: 'Enter pregnancies count',
                          controller: _pregnanciesCountController,
                          validator: (value) =>
                              value == null || int.tryParse(value) == null
                                  ? 'Please enter integer number'.tr
                                  : null,
                        ),
                        SizedBox(
                          height: 55 * SizeConfig.heightMultiplier(context),
                        ),
                        SizedBox(
                          width: 343 * SizeConfig.widthMultiplier(context),
                          height: 52 * SizeConfig.heightMultiplier(context),
                          child: PrimaryButton(
                              text: 'Confirm',
                              onPressed: () {
                                if (_pregnanciesCountFormKey.currentState!
                                    .validate()) {
                                  Navigator.pop(
                                      context,
                                      int.parse(
                                          _pregnanciesCountController.text));
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    if (newCount != null) {
      ref.read(animalListProvider.notifier).updateAnimal(widget.animal.copyWith(pregnanciesCount: newCount));
    }
  }

  Future<bool?> _confirmDeletion(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => ConfirmDeleteDialog(
            content:
                'Are you sure you want to delete the details, files etc.?'.tr));
  }

  Future<void> _showMatingDatePickerModalSheet(BreedingEventVariables event) async {
    final DateTime? newMatingDate = await showDatePicker(
      context: context,
      initialDate: event.breedingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );

    if (newMatingDate != null) {
      ref.read(breedingEventListProvider(widget.animal.id!).notifier)
          .updateEvent(event.copyWith(breedingDate: newMatingDate));
    }
  }
}
