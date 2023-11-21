import 'package:flutter/material.dart';
import 'list_of_breeding_events.dart';
// import 'path_to_breeding_event_file.dart';

class BreedingEventChildrenList extends StatelessWidget {
  final BreedingEventVariables breedingEvent;

  const BreedingEventChildrenList({Key? key, required this.breedingEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children List - ${breedingEvent.eventNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Number: ${breedingEvent.eventNumber}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Children List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Display the list of children
            if (breedingEvent.children.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: breedingEvent.children.map((child) {
                  return ListTile(
                    title: Text('Child: ${child.animalName}'),
                    // Add more information about the child as needed
                    // Example: subtitle: Text('DOB: ${child.dateOfBirth}'),
                  );
                }).toList(),
              )
            else
              Text('No children recorded for this breeding event.'),
          ],
        ),
      ),
    );
  }
}
