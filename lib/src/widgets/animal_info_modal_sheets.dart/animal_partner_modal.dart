import 'package:flutter/material.dart';

import '../../data/classes.dart';

class AnimalPartnerModal extends StatefulWidget {
  const AnimalPartnerModal({
    super.key,
    required this.ovianimals,
  });

  final List<OviVariables> ovianimals;

  @override
  State<AnimalPartnerModal> createState() => _AnimalPartnerModalState();
}

class _AnimalPartnerModalState extends State<AnimalPartnerModal> {
  String searchQuery = '';
  int selectedPartnerId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Select Partner",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search By Name Or ID",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.ovianimals.length,
                itemBuilder: (context, index) {
                  final OviDetails = widget.ovianimals[index];
                  final isSelected = OviDetails.id == selectedPartnerId;
                  // Apply the filter here
                  if (!OviDetails.animalName
                      .toLowerCase()
                      .contains(searchQuery) &&
                      !OviDetails.selectedAnimalType
                          .toLowerCase()
                          .contains(searchQuery)) {
                    return Container(); // Skip this item if it doesn't match the search query
                  }

                  return ListTile(
                    tileColor: isSelected
                        ? Colors.green.withOpacity(0.5)
                        : null,
                    shape: isSelected
                        ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )
                        : null,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[100],
                      backgroundImage: OviDetails.selectedOviImage,
                      child: OviDetails.selectedOviImage == null
                          ? const Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                        color: Colors.grey,
                      )
                          : null,
                    ),
                    title: Text(OviDetails.animalName),
                    subtitle: Text(OviDetails.selectedAnimalType),
                    onTap: () {
                      setState(() {
                        selectedPartnerId = OviDetails.id;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedPartnerId);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
