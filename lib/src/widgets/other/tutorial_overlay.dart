import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../pages/main_widgets/navigation_bar_guest_mode.dart';

class TutorialOverlay extends StatefulWidget {
  final List steps;
  final List<String> hints;
  final Function onFinished;
  final double? closeButtonPositionLeft;
  final double? nextButtonPositionLeft;
  final TutorialController? controller;

  const TutorialOverlay(
      {Key? key,
      required this.steps,
      required this.hints,
      required this.onFinished,
      this.closeButtonPositionLeft,
      this.nextButtonPositionLeft,
      this.controller})
      : super(key: key);

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  Map<GlobalKey, RenderBox> boxes = {};
  int currentStepIndex = 0;
  late TutorialController _tutorialController;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculatePositions());
    _tutorialController = widget.controller ?? TutorialController();
    _tutorialController.addListener(() {
      if (currentStepIndex != _tutorialController.stepIndex) {
        currentStepIndex = _tutorialController.stepIndex;
        _calculatePositions();
      }
      if(disabled != _tutorialController.disabled) {
        setState(() {
          disabled = _tutorialController.disabled;
        });
      }
    });
  }

  void _calculatePositions() {
    setState(() {
      List<GlobalKey> keys = [];
      for (var step in widget.steps) {
        if (step is GlobalKey) {
          keys.add(step);
        }
        if (step is List<GlobalKey>) {
          keys.addAll(step);
        }
      }
      for (var key in keys) {
        final RenderBox? box =
            key.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          boxes[key] = box;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (boxes.isEmpty || disabled) {
      return Container();
    }
    List<RenderBox> currentBoxes = [];
    final currentStep = widget.steps[currentStepIndex];
    if (currentStep is GlobalKey) {
      currentBoxes.add(boxes[currentStep]!);
    } else if (currentStep is List) {
      for (var key in currentStep) {
        if(boxes[key] != null) {
          currentBoxes.add(boxes[key]!);
        }
      }
    }

    return Stack(
      children: [
        CustomPaint(
            size: MediaQuery.of(context).size,
            painter: HolePainter(boxes: currentBoxes)),
        Positioned(
          top: 51,
          left: widget.closeButtonPositionLeft,
          right: widget.closeButtonPositionLeft == null ? 16 : null,
          child: SizedBox(
            width: 40,
            height: 40,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const NavigationBarGuestMode(), // Replace with your desired page.
                  ),
                );
              },
              fillColor: Colors.white,
              elevation: 10,
              shape: const CircleBorder(),
              child: const SizedBox(
                width: 24,
                height: 24,
                child: Image(
                  image: AssetImage('assets/icons/frame/24px/24_Close.png'),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: widget.nextButtonPositionLeft,
          right: widget.nextButtonPositionLeft == null ? 16 : null,
          bottom: 91,
          child: SizedBox(
            width: 40,
            height: 40,
            child: RawMaterialButton(
              onPressed: () {
                bool? allowed = _tutorialController.beforeStepChanged != null
                    ? _tutorialController.beforeStepChanged!(currentStepIndex)
                    : true;
                if (allowed == true) {
                  if(currentStepIndex == widget.steps.length - 1) {
                    widget.onFinished();
                  } else {
                    _tutorialController.stepIndex = currentStepIndex + 1;
                  }
                }
              },
              fillColor: Colors.white,
              elevation: 10,
              shape: const CircleBorder(),
              child: const SizedBox(
                width: 24,
                height: 24,
                child: Image(
                  image:
                      AssetImage('assets/icons/frame/24px/24_Arrow_right.png'),
                ),
              ),
            ),
          ),
        ),
        _buildHint(),
      ],
    );
  }

  Widget _buildHint() {
    if (boxes.isEmpty) {
      return Container();
    }
    if (widget.hints.length < currentStepIndex + 1) {
      return Container();
    }
    double left = 32;
    final currentStep = widget.steps[currentStepIndex];
    RenderBox? currentBox;
    double? top;
    if (currentStep is GlobalKey) {
      currentBox = boxes[currentStep];
      top = currentBox!.localToGlobal(Offset.zero).dy +
          currentBox.size.height +
          43;
    } else if (currentStep is List<GlobalKey>) {
      print(boxes);
      currentBox = boxes[currentStep.first];
      top = currentBox!.localToGlobal(Offset.zero).dy +
          currentBox.size.height +
          144;
    }

    return Positioned(
        left: left,
        top: top,
        width: 299 * SizeConfig.widthMultiplier(context),
        child: Material(
          color: Colors.transparent,
          child: Text(
            widget.hints[currentStepIndex],
            style: AppFonts.headline1(color: AppColors.grayscale00),
          ),
        ));
  }
}

class HolePainter extends CustomPainter {
  final List<RenderBox> boxes;

  HolePainter({super.repaint, required this.boxes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF232323).withOpacity(0.9);
    final arrowPaint = Paint()
      ..color = const Color(0xFF939393)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    List<Rect> holes = [];
    final holesPath = Path();
    for (var box in boxes) {
      if (box.attached) {
        final position = box.localToGlobal(Offset.zero);
        final size = box.size;
        final center =
            Offset(position.dx + size.width / 2, position.dy + size.height / 2);
        final rect = Rect.fromCircle(
            center: center, radius: max(size.width, size.height) / 2 + 25);
        holesPath.addOval(rect);
        holes.add(rect);
      }
    }
    holesPath.close();

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          holesPath,
        ),
        paint);

    if (holes.length > 1) {
      final firstArrowEnd =
          Offset(holes.first.left - 30, holes.first.bottom + 30);

      final path = Path()
        ..moveTo(firstArrowEnd.dx, firstArrowEnd.dy)
        ..arcToPoint(Offset(firstArrowEnd.dx - 30, firstArrowEnd.dy + 30),
            radius: const Radius.circular(90),
            largeArc: false,
            clockwise: false);
      canvas.drawPath(path, arrowPaint);
      _drawArrowEnd(canvas, firstArrowEnd, 9, 1.8 * pi, arrowPaint);

      final lastArrowEnd = Offset(holes.last.left - 30, holes.last.top);
      path.moveTo(lastArrowEnd.dx, lastArrowEnd.dy);
      path.arcToPoint(Offset(lastArrowEnd.dx - 30, lastArrowEnd.dy - 30),
          radius: const Radius.circular(90), largeArc: false, clockwise: true);
      canvas.drawPath(path, arrowPaint);
      _drawArrowEnd(canvas, lastArrowEnd, 9, 0.2 * pi, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawArrowEnd(Canvas canvas, Offset pointA, double length,
      double arrowDirection, Paint paint) {
    final firstLineDirection = arrowDirection + 3 * pi / 4;
    // Calculate end point of the original line
    final pointB = Offset(pointA.dx + cos(firstLineDirection) * length,
        pointA.dy + sin(firstLineDirection) * length);

    // Draw the original line
    canvas.drawLine(pointA, pointB, paint);

    // Calculate end point of the perpendicular line from the same starting point
    // The direction is adjusted by 90 degrees (pi/2 radians) for perpendicular direction
    final pointPerpendicular = Offset(
        pointA.dx + cos(firstLineDirection + pi / 2) * length,
        pointA.dy + sin(firstLineDirection + pi / 2) * length);

    // Draw the perpendicular line
    canvas.drawLine(pointA, pointPerpendicular, paint);
  }
}

class TutorialController extends ChangeNotifier {
  int _stepIndex = 0;
  bool _disabled = false;

  bool get disabled => _disabled;

  set disabled(bool value) {
    _disabled = value;
    notifyListeners();
  }

  TutorialController({this.beforeStepChanged});

  int get stepIndex => _stepIndex;
  final bool Function(int)? beforeStepChanged;

  set stepIndex(int value) {
    _stepIndex = value;
    notifyListeners();
  }
}
