import 'package:flutter/material.dart';

class FamilyTree extends StatefulWidget {
  const FamilyTree({super.key});

  @override
  State<FamilyTree> createState() => _FamilyTree();
}

class _FamilyTree extends State<FamilyTree> {
  List<Widget> fatherParents = [
    const AnimalCard(name: 'F1'),
    const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomConnectorLine(),
        VerticalConnector(),
      ],
    ), // Custom connector line
    const AnimalCard(name: 'F2'),
  ];

  List<Widget> motherParents = [
    const AnimalCard(name: 'M1'),
    const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomConnectorLine(),
        VerticalConnector(),
      ],
    ), // Custom connector line
    const AnimalCard(name: 'M2'),
  ];

  List<Widget> parentList = [
    const AnimalCard(name: 'Father'),
    const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomConnectorLine(),
        VerticalConnector(),
      ],
    ), // Custom connector line
    const AnimalCard(name: 'Mother'),
  ];

  List<Widget> animalList = [
    const AnimalCard(name: 'Animal'),
    const VerticalConnector(),
  ];

  List<Widget> childrenList = [
    const AnimalCard(name: 'Child 1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 0.5,
        maxScale: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Father's Parents
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: fatherParents,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: motherParents,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 50), // Space between Father's Parents and Father
                  // Parents: Father and Mother
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: parentList,
                  ),
                  const SizedBox(
                      height: 50), // Space between parents and "The Animal"
                  // The Animal
                  ...animalList,
                  const SizedBox(
                      height: 50), // Space between "The Animal" and children
                  // Mother's Parents

                  // The Children in a Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < childrenList.length; i++) ...[
                          if (i > 0) const CustomConnectorLine(),
                          childrenList[i],
                          if (i < childrenList.length - 1)
                            const CustomConnectorLine(),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new child when the button is pressed
          setState(() {
            childrenList
                .add(AnimalCard(name: 'Child ${childrenList.length + 1}'));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String name;

  const AnimalCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: const Color.fromARGB(255, 248, 243, 208),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomConnectorLine extends StatelessWidget {
  const CustomConnectorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(30, 2), // Adjust the size as needed
      painter: CustomLinePainter(),
    );
  }
}

class CustomLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    // Draw the horizontal line
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class VerticalConnector extends StatelessWidget {
  const VerticalConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(2, 30), // Adjust the size as needed
      painter: VerticalLinePainter(),
    );
  }
}

class VerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final startPoint = Offset(size.width / 2, 0);
    final endPoint = Offset(size.width / 2, size.height * 3);

    // Draw the vertical line
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
