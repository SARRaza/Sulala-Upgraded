import 'package:flutter/material.dart';

import 'family_tree_node.dart';

enum ItemType { personCard, expandButton }

class FamilyTreeItem extends StatelessWidget {
  const FamilyTreeItem(
      {super.key,
      this.selected = false,
      this.showGender = false,
      required this.node,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(horizontal: 7.5)});
  final bool selected;
  final bool showGender;
  final FamilyTreeNode node;
  final void Function(ItemType type)? onTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    if ((node.children.isNotEmpty || node.parents.isNotEmpty || node.animal == null) &&
        !selected &&
        !node.expanded) {
      return buildExpandButton();
    } else {
      return buildPersonCard();
    }
  }

  Widget buildPersonCard() {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(ItemType.personCard);
        }
      },
      child: Container(
        margin: margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                shadows: selected
                    ? [
                        const BoxShadow(
                          color: Color(0xAFF0D031),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ]
                    : null,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                        width: 72,
                        height: 72,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: node.animal!.selectedOviImage != null
                            ? Image(
                                image: node.animal!.selectedOviImage!,
                              )
                            : null),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          node.animal!.animalName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFF232323),
                              fontSize: 14,
                              fontFamily: 'IBM Plex Sans',
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (showGender)
                        SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset(node.animal!.selectedOviGender ==
                                'Male'
                                ? 'assets/avatars/48px/gender_male.png'
                                : 'assets/avatars/80px/gender_female.png')),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ID #${node.animal!.id}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF43464C),
                    fontSize: 12,
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.24,
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: 72,
                  child: SizedBox(
                    width: 72,
                    child: Text(
                      node.animal!.selectedOviChips.join(', '),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: node.animal!.selectedOviChips.contains('Dead')
                            ? const Color(0xFFFF3E2C)
                            : const Color(0xFF43464C),
                        fontSize: 10,
                        fontFamily: 'IBM Plex Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpandButton() {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(ItemType.expandButton);
        }
      },
      child: Container(
        width: 72,
        height: 72,
        margin: margin,
        padding: const EdgeInsets.all(14.40),
        decoration: ShapeDecoration(
          color: const Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(43.20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 43.20,
                height: 43.20,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Image.asset('assets/avatars/48px/24_Add.png')),
          ],
        ),
      ),
    );
  }
}
