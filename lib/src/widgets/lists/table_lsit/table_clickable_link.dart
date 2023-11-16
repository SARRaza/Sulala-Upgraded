import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:url_launcher/url_launcher_string.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TableClickableText extends StatefulWidget {
  final String text1;
  final String urlText;
  final String url;
  final String iconPath;

  const TableClickableText({
    Key? key,
    required this.text1,
    required this.urlText,
    required this.url,
    required this.iconPath,
  }) : super(key: key);

  @override
  State<TableClickableText> createState() => _TableClickableTextState();
}

class _TableClickableTextState extends State<TableClickableText> {
  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrlString(widget.url)) {
      throw Exception('Could not launch ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              truncateTextWithEllipsis(widget.text1, 25),
              style: AppFonts.body2(
                color: AppColors.grayscale70,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Image.asset(
                  widget.iconPath,
                ),
                SizedBox(width: globals.widthMediaQuery * 7),
                GestureDetector(
                  onTap: _launchUrl,
                  child: Text(
                    widget.urlText,
                    style: TextStyle(
                      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                      color: AppColors.primary30,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


// Exapmle of use:

// const TableClickableText(
//                     text1: 'Clickable Text',
//                     urlText: 'Email@gmail.com',
//                     url: "https://www.google.com/",
//                   ),