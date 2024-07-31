import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String title;
  final String value;
  final String subtitle;
  final double titleFontSize;
  final double valueFontSize;
  final double subtitleFontSize;
  final String titleColor;
  final String valueColor;
  final String subtitleColor;
  final String backgroundColor;

  const CustomerCard({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.titleFontSize,
    required this.valueFontSize,
    required this.subtitleFontSize,
    required this.titleColor,
    required this.valueColor,
    required this.subtitleColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        width: width,
        height: height,
        color: Color(int.parse(backgroundColor)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(titleColor)),
                  ),
                ),
                const Spacer(),
                // Icon(
                //   Icons.more_vert,
                //   color: Color(iconColor),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
                color: Color(int.parse(valueColor)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Color(int.parse(subtitleColor)),
                fontSize: subtitleFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
