import 'package:flutter/material.dart';

import 'family_tree_node.dart';

class GraphPainter extends CustomPainter {
  final FamilyTreeNode node;
  final GlobalKey stackKey;
  static const double cornerRadius = 12.0;

  GraphPainter(this.node, this.stackKey);

  @override
  void paint(Canvas canvas, Size size) {
    final stackRenderObject =
        stackKey.currentContext!.findRenderObject() as RenderBox;

    final fillPaint = Paint()
      ..color = const Color(0xFF1C793B)
      ..style = PaintingStyle.fill;
    final paint = Paint()
      ..color = const Color(0xFF1C793B)
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (node.parents.isNotEmpty) {
      drawParentsBranch(node, stackRenderObject, canvas, fillPaint, paint);
    }

    if (node.children.isNotEmpty) {
      drawChildrenBranch(node, stackRenderObject, canvas, fillPaint, paint);
    }
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate.node != node || oldDelegate.stackKey != stackKey;
  }

  void drawParentsBranch(FamilyTreeNode node, RenderBox stackRenderObject,
      Canvas canvas, Paint fillPaint, Paint paint) {
    if (node.key.currentContext == null) {
      return;
    }
    final personRenderObject =
        node.key.currentContext!.findRenderObject() as RenderBox;
    final personPosition = personRenderObject.localToGlobal(Offset.zero,
        ancestor: stackRenderObject);
    final topCenter = Offset(
        personPosition.dx + personRenderObject.size.width / 2,
        personPosition.dy - 16);

    canvas.drawCircle(topCenter, 3, fillPaint);

    var branching = Offset(topCenter.dx, topCenter.dy - 36);
    canvas.drawLine(topCenter, branching, paint);

    final fatherRenderObject =
        node.parents.first.key.currentContext!.findRenderObject() as RenderBox;
    final fatherPosition = fatherRenderObject.localToGlobal(Offset.zero,
        ancestor: stackRenderObject);
    final fatherXCenter = fatherPosition.dx + fatherRenderObject.size.width / 2;
    final fatherBottom = fatherPosition.dy + fatherRenderObject.size.height + 8;

    var path = Path();

    var cornerEnd = Offset(fatherXCenter, branching.dy - cornerRadius);

    if (node.parents.length > 1) {
      canvas.drawLine(
          branching, Offset(fatherXCenter + cornerRadius, branching.dy), paint);
      path = Path()
        ..moveTo(fatherXCenter + cornerRadius, branching.dy)
        ..arcToPoint(cornerEnd,
            radius: const Radius.circular(cornerRadius), largeArc: false);
      canvas.drawPath(path, paint);
    } else {
      canvas.drawLine(branching, cornerEnd, paint);
    }

    canvas.drawLine(cornerEnd, Offset(fatherXCenter, fatherBottom + 5), paint);

    var trianglePath = Path();
    trianglePath.moveTo(fatherXCenter, fatherBottom);
    trianglePath.lineTo(fatherXCenter - 3, fatherBottom + 5);
    trianglePath.lineTo(fatherXCenter + 3, fatherBottom + 5);
    trianglePath.lineTo(fatherXCenter, fatherBottom);
    canvas.drawPath(trianglePath, fillPaint);

    if (node.parents.length > 1) {
      final motherRenderObject =
          node.parents.last.key.currentContext!.findRenderObject() as RenderBox;
      final motherPosition = motherRenderObject.localToGlobal(Offset.zero,
          ancestor: stackRenderObject);
      final motherXCenter =
          motherPosition.dx + motherRenderObject.size.width / 2;
      final motherBottom =
          motherPosition.dy + motherRenderObject.size.height + 8;

      canvas.drawLine(
          branching, Offset(motherXCenter - cornerRadius, branching.dy), paint);

      cornerEnd = Offset(motherXCenter, branching.dy - cornerRadius);
      path = Path()
        ..moveTo(motherXCenter - cornerRadius, branching.dy)
        ..arcToPoint(cornerEnd,
            radius: const Radius.circular(cornerRadius),
            largeArc: false,
            clockwise: false);
      canvas.drawPath(path, paint);

      canvas.drawLine(
          cornerEnd, Offset(motherXCenter, motherBottom + 5), paint);

      trianglePath = Path();
      trianglePath.moveTo(motherXCenter, motherBottom);
      trianglePath.lineTo(motherXCenter - 3, motherBottom + 5);
      trianglePath.lineTo(motherXCenter + 3, motherBottom + 5);
      trianglePath.lineTo(motherXCenter, motherBottom);
      canvas.drawPath(trianglePath, fillPaint);
    }

    for (var node in node.parents) {
      if (node.parents.isNotEmpty && node.expanded) {
        drawParentsBranch(node, stackRenderObject, canvas, fillPaint, paint);
      }
    }
  }

  void drawChildrenBranch(FamilyTreeNode node, RenderBox stackRenderObject,
      Canvas canvas, Paint fillPaint, Paint paint) {
    final personRenderObject =
        node.key.currentContext!.findRenderObject() as RenderBox;
    final personPosition = personRenderObject.localToGlobal(Offset.zero,
        ancestor: stackRenderObject);

    final bottomCenter = Offset(
        personPosition.dx + personRenderObject.size.width / 2,
        personPosition.dy + personRenderObject.size.height + 16);
    canvas.drawCircle(bottomCenter, 3, fillPaint);
    final branching = Offset(bottomCenter.dx, bottomCenter.dy + 36);
    canvas.drawLine(bottomCenter, branching, paint);

    for (var i = 0; i < node.children.length; i++) {
      final renderObject =
          node.children[i].key.currentContext!.findRenderObject() as RenderBox;
      final position =
          renderObject.localToGlobal(Offset.zero, ancestor: stackRenderObject);
      final xCenter = position.dx + renderObject.size.width / 2;
      final top = position.dy - 8;
      if (i == 0) {
        var cornerEnd = Offset(xCenter, branching.dy + cornerRadius);
        if (node.children.length > 1) {
          canvas.drawLine(
              branching, Offset(xCenter + cornerRadius, branching.dy), paint);
          var path = Path()
            ..moveTo(xCenter + cornerRadius, branching.dy)
            ..arcToPoint(cornerEnd,
                radius: const Radius.circular(cornerRadius),
                largeArc: false,
                clockwise: false);
          canvas.drawPath(path, paint);
        } else {
          canvas.drawLine(branching, cornerEnd, paint);
        }
        canvas.drawLine(cornerEnd, Offset(xCenter, top - 5), paint);
      } else if (i == (node.children.length - 1)) {
        canvas.drawLine(
            branching, Offset(xCenter - cornerRadius, branching.dy), paint);
        var cornerEnd = Offset(xCenter, branching.dy + cornerRadius);
        var path = Path()
          ..moveTo(xCenter - cornerRadius, branching.dy)
          ..arcToPoint(cornerEnd,
              radius: const Radius.circular(cornerRadius), largeArc: false);
        canvas.drawPath(path, paint);
        canvas.drawLine(cornerEnd, Offset(xCenter, top - 5), paint);
      } else {
        canvas.drawLine(
            Offset(xCenter, branching.dy), Offset(xCenter, top - 5), paint);
      }
      final trianglePath = Path();
      trianglePath.moveTo(xCenter, top);
      trianglePath.lineTo(xCenter - 3, top - 5);
      trianglePath.lineTo(xCenter + 3, top - 5);
      trianglePath.lineTo(xCenter, top);
      canvas.drawPath(trianglePath, fillPaint);

      if (node.children[i].children.isNotEmpty && node.children[i].expanded) {
        drawChildrenBranch(
            node.children[i], stackRenderObject, canvas, fillPaint, paint);
      }
    }
  }
}
